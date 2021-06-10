### Source code for SkinCancer Project

### Dependencies
1. Django
2. Pytorch
3. scikit-learn

if using anaconda
```code
conda env create -f env.yml
```

### Dataset
**The HAM10000 dataset, a large collection of multi-source dermatoscopic images of common pigmented skin lesions** (https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/DBW86T)
- Image Dataset: HAM10000_images_part_1.zip, HAM10000_images_part_2.zip
- Segmentation Label: HAM10000_segmentations_lesion_tschandl.zip
- Classification Label: HAM10000_metadata.tab

### Model
- Classification Model(Densenet121): Densely Connected Convolutional Networks(https://arxiv.org/pdf/1608.06993.pdf)
- Segmentation Model(U_net): Usuyama Github (https://github.com/usuyama/pytorch-unet)
- XAI Model(Grad-Cam): Gradient-weighted Class Activation Mapping (https://arxiv.org/abs/1610.02391)

### Web
- Djange: Sharmasw GitHub (https://github.com/sharmasw/ImageClassification_DjangoApp, https://www.youtube.com/watch?v=mgX-2_ybqNk&t=849s)

### Proposed Model
**Segmentation + Original Image Input -> Model Training**  
1. F1 score increase: 0.79 -> **0.81**
2. Generalization

**Dataset of Input Image**
<img src="https://raw.githubusercontent.com/wjddyd66/Project/master/image/9.png" alt="png">

**GradCam Result of Only Image Input Train // Label = Actinic keratoses and intraepithelial carcinoma**  
<img src="https://raw.githubusercontent.com/wjddyd66/Project/master/image/10.png" alt="png">

**Dataset of Segmentation + Input Image**
<img src="https://raw.githubusercontent.com/wjddyd66/Project/master/image/11.png" alt="png">

**GradCam Result of Segmentation + Image Input Train  // Label = Actinic keratoses and intraepithelial carcinoma**  
<img src="https://raw.githubusercontent.com/wjddyd66/Project/master/image/12.png" alt="png">
