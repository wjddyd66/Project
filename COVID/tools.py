#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 11 18:42:17 2018

@author: juanma
"""

# general use
import numpy as np
import random
import torch

# %%
"""
 Auxiliary functions for correct exploration of Searchable Models 
"""


def predict_accuracies_with_surrogate(configurations, surrogate, device):
    # uses surrogate to evaluate input configurations

    accs = []

    for c in configurations:
        accs.append(surrogate.eval_model(c, device))

    return accs


def update_surrogate_dataloader(surrogate_dataloader, configurations, accuracies):
    for conf, acc in zip(configurations, accuracies):
        surrogate_dataloader.add_datum(conf, acc)

def train_simple_surrogate(model, criterion, optimizer, data_tensors, num_epochs, device):
    for epoch in range(num_epochs):

        model.train(True)  # Set model to training mode

        # get the inputs
        for batch in range(len(data_tensors[0])):
            inputs, outputs = data_tensors[0][batch], data_tensors[1][batch]

            # move to device
            inputs = inputs.to(device)
            outputs = outputs.to(device)

            optimizer.zero_grad()

            # forward
            with torch.set_grad_enabled(True):
                f_outputs = model(inputs)

                loss = criterion(f_outputs, outputs)
                loss.backward()
                optimizer.step()

    model.train(False)
    return loss.item()

def train_surrogate(surrogate, surrogate_dataloader, surrogate_optimizer, surrogate_criterion, args, device):
    s_data = surrogate_dataloader.get_data(to_torch=True)
    err = train_simple_surrogate(surrogate, surrogate_criterion,
                                      surrogate_optimizer, s_data,
                                      args.epochs_surrogate, device)

    return err


def sample_k_configurations(configurations, accuracies_, k, temperature):
    accuracies = np.array(accuracies_)
    p = accuracies / accuracies.sum()
    powered = pow(p, 1.0 / temperature)
    p = powered / powered.sum()

    indices = np.random.choice(len(configurations), k, replace=False, p=p)
    samples = [configurations[i] for i in indices]

    return samples


def sample_k_configurations_uniform(configurations, k):
    indices = np.random.choice(len(configurations), k)
    samples = [configurations[i] for i in indices]

    return samples


def merge_unfolded_with_sampled(previous_top_k_configurations, unfolded_configurations, layer):
    # normally, the outpout configurations are evaluated with the surrogate function

    # unfolded_configurations is a configuration for a single layer, so it does not have seq_len dimension
    # previous_top_k_configurations is composed of configurations of size (seq_len,3)

    merged = []

    if not previous_top_k_configurations:
        # this typically executes at the very first iteration of the sequential exploration
        for unfolded_conf in unfolded_configurations:

            if layer == 0:
                new_conf = np.expand_dims(unfolded_conf, 0)
            else:
                raise ValueError(
                    'merge_unfolded_with_sampled: Something weird is happening. previous_top_k_configurations is None, but layer != 0')

            merged.append(new_conf)
    else:
        # most common pathway of execution: there exist previous configurations
        for prev_conf in previous_top_k_configurations:
            for unfolded_conf in unfolded_configurations:
                new_conf = np.copy(prev_conf)
                if layer < len(prev_conf):
                    new_conf[layer] = unfolded_conf
                else:
                    new_conf = np.concatenate([prev_conf, np.expand_dims(unfolded_conf, 0)], 0)

                merged.append(new_conf)

    return merged


def sample_k_configurations_directly(k, max_progression_levels, get_possible_layer_configurations_fun):
    configurations = []

    possible_confs_per_layer = []
    for l in range(max_progression_levels):
        possible_confs_per_layer.append(get_possible_layer_configurations_fun(l))

    for sample in range(k):
        num_layers_sample = random.randint(1, max_progression_levels)

        conf = []
        for layer in range(num_layers_sample):
            random_layer_conf = sample_k_configurations_uniform(possible_confs_per_layer[l], 1)
            conf.append(random_layer_conf)

        conf = np.array(conf)[:, 0, :]
        configurations.append(conf)

    return configurations


def compute_temperature(iteration, args):
    temp = (args.initial_temperature - args.final_temperature) * np.exp(
        -(iteration + 1.0) ** 2 / args.temperature_decay ** 2) + args.final_temperature
    return temp
