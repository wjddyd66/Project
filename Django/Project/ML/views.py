from django.shortcuts import render
from django.template.context_processors import request
import pandas as pd
from ML.models import Park
from ML.models import People
from ML.models import Pop
from ML.models import River
from ML.models import Road
from ML.models import Univ
import numbers
import math
from sklearn.externals import joblib
from ML.euclidean import GeoUtil
import os

def IndexFunc(request):
    return render(request, 'index.html')

def AnalFunc(request):
    file_name = os.path.join(os.path.dirname(os.path.dirname(__file__)),'ML/model.pkl')
    model = joblib.load(file_name)

    count = int(request.POST.get('count'))
    data = list()
    for i in range(0,count):
        result=request.POST.get(str(i))
        imsi = repr(result)
        x,y = imsi.split(',')
        data.append([float(y[1:len(y)-2]),float(x[2:len(x)])])
        
    
    data_park = pd.DataFrame(list(Park.objects.all().values()))
    data_people = pd.DataFrame(list(People.objects.all().values()))
    data_pop = pd.DataFrame(list(Pop.objects.all().values()))
    data_river = pd.DataFrame(list(River.objects.all().values()))
    data_road = pd.DataFrame(list(Road.objects.all().values()))
    data_univ = pd.DataFrame(list(Univ.objects.all().values()))
    

    
    results = []
    for s in range(0,len(data)):
        index=1   
        count = 0
        sum = 0
        result = []
        min1 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_park["x"][0], data_park["y"][0])          
        min2 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_pop["x"][0], data_pop["y"][0])          
        min3 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_river["x"][0], data_river["y"][0])          
        min4 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_road["x"][0], data_road["y"][0])          
        min5 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_univ["x"][0], data_univ["y"][0])          
        
        for a in range(0, len(data_park)):
            d1 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_park["x"][a], data_park["y"][a])
            if d1 < min1:
                min1 = d1            
        
        for a in range(0, len(data_pop)):
            d2 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_pop["x"][a], data_pop["y"][a])
            if d2 < min2:
                min2 = d2 
        
        for a in range(0, len(data_river)):
            d3 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_river["x"][a], data_river["y"][a])
            if d3 < min3:
                min3 = d3 
        
        for a in range(0, len(data_road)):
            d4 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_road["x"][a], data_road["y"][a])
            if d4 < min4:
                min4 = d4 
        
        for a in range(0, len(data_univ)):
            d5 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_univ["x"][a], data_univ["y"][a])
            if d5 < min5:
                min5 = d5         
    
        for a in range(0, len(data_people)):
            d6 = GeoUtil.get_harversion_distance(data[s][0], data[s][1], data_people["x"][a], data_people["y"][a])
            if d6 < 1.5:
                sum += data_people["count"][a]
                count += 1
        
        if(count ==0):
            sum = 1
            count=1
        
        people = sum/count
        result1 = (people-0)/(412554-0)
        result2 = (min1-0.03253)/(14.97119-0.03253)
        result3 = (min2-0.06655)/(16.08754-0.06655)
        result4 = (min4-0.04874)/(10.9346-0.04874)
        result5 = (min3-0.03363)/(8.05676-0.03363)
        result6 = (min5-0.14916)/(11.71905-0.14916)
        
        #people, park, population, road, river, univ, 1~3(1: 최상, 2:중간, 3: 최악)
        Data = pd.DataFrame(data=[[result1,result2,result3,result4,result5,result6]])
        result7 = model.predict(Data)[0]
        result1 = round(result1 *100)
        result2 = 100-round(result2 *100)
        result3 = 100-round(result3 *100)
        result4 = 100-round(result4 *100)
        result5 = 100-round(result5 *100)
        result6 = 100-round(result6 *100)
        if(result7==1):
            result7 = '상'
        elif(result7==2):
            result7='중'
        else:
            result7='하'
            
        results.append({"result1":result1,"result2":result2,"result3":result3,"result4":result4,"result5":result5,"result6":result6,"result7":result7,"x":data[s][0],"y":data[s][1],"index":index})
        index = index+1
        print(index)  
    print(results)
    return render(request, 'charts.html',{"result":results})

def map(request):
    return render(request,'map.html')
