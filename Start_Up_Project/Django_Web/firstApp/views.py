from django.shortcuts import render
# Create your views here.
from django.core.files.storage import FileSystemStorage
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator

from models.Skin_Cancer_Model import Model
import pandas as pd
import torch
import shutil
import os

# Skin Cancer Model
model = Model()
model.load_state_dict(torch.load('./models/final_model.pt'))
model.eval()

def index(request):
    context={'a':1}
    return render(request,'index.html',context)

@method_decorator(csrf_exempt, name='dispatch')
def predictImage(request):
    fileObj = request.FILES['filePath']
    fs = FileSystemStorage()
    filePathName = fs.url(fileObj.name)

    testimage = '.'+filePathName
    saveimage = '.'+filePathName.split('.')[0]+'_result.png'

    model(testimage, saveimage)

    context = {'result_path': saveimage}

    return render(request, 'predict_result.html', context)

@method_decorator(csrf_exempt, name='dispatch')
def feedback(request):
    val_feedback = int(request.POST.dict()['feedback'])

    result_png = request.POST.dict()['result_png']
    root_path = '/'.join(result_png.split('/')[:-1])+'/'
    # Find Original Png Name
    b = result_png.split('/')[-1].split('_')[:-1]
    original_png = ''
    for i, bb in enumerate(b):
        if i != len(b) - 1:
            original_png = original_png + bb + '_'
        else:
            original_png = root_path + original_png + bb + '.png'

    if not os.path.isfile(original_png):
        original_png = '.'.join(original_png.split('.')[:-1])+'.jpg'

    x_path = './mis_data/'+original_png.split('/')[-1]
    xx_path = './data/'+original_png.split('/')[-1]
    y_path = './mis_data/' + result_png.split('/')[-1]

    # If Feedback is bad
    if val_feedback < 3:
        # Save Model Input & Output
        shutil.copy(original_png, x_path)
        shutil.copy(result_png, y_path)

        # Save Model for model training
        shutil.copy(original_png, xx_path)
        meta = pd.read_csv('./data/Metadata.csv')
        meta = meta.append({'image_id': xx_path, 'dx': None, 'date': pd.Timestamp.now()}, ignore_index=True)
        meta = meta.drop_duplicates(['image_id'], keep='last')
        meta.to_csv('./data/Metadata.csv', index = False)

    context = {'result_path': result_png}

    return render(request, 'predict_result2.html', context)

def viewDataBase(request):
    import os
    listOfImages=os.listdir('./media/')
    listOfImagesPath=['./media/'+i for i in listOfImages]
    context={'listOfImagesPath':listOfImagesPath}
    return render(request,'viewDB.html',context) 