# goExcel.py
import pandas as pd
from pack.euclidean import GeoUtil

# 결과 엑셀로 저장하기
def makeExcel(name_rental, park, pop, river, road, univ, avg):
    data.append([name_rental]+[park]+[pop]+[river]+[road]+[univ]+[avg])
    table = pd.DataFrame(data, columns=('name_rental', 'Park', 'pop', 'river', 'road', 'univ', 'avg'))
    table.to_excel("Data.xlsx", encoding="cp949", index=True)


# 공원 데이터 로드
data_park = pd.read_excel("park.xlsx", encoding = "CP949")
data_park.columns = ["name", "x", "y"]
data_park = data_park.dropna(axis=0)
# 관광명소
data_pop = pd.read_excel("pop.xlsx", encoding = "CP949")
data_pop.columns = ["name", "x", "y"]
data_pop = data_pop.dropna(axis=0)
# 강
data_river = pd.read_excel("river.xlsx", encoding = "CP949")
data_river.columns = ["name", "x", "y"]
data_river = data_river.dropna(axis=0)
# 자전거 도로
data_road = pd.read_excel("road.xlsx", encoding = "CP949")
data_road.columns = ["name", "x", "y"]
data_road = data_road.dropna(axis=0)
# 대학교
data_univ = pd.read_excel("univ.xlsx", encoding = "CP949")
data_univ.columns = ["name", "x", "y"]
data_univ = data_univ.dropna(axis=0)
# 유동인구
data_people = pd.read_excel("people.xlsx", encoding = "CP949")
data_people.columns = ["name", "count", "x", "y"]
data_people = data_people.dropna(axis=0)


# 대여소 데이터 로드
data_rental = pd.read_excel("map.xlsx", encoding = "CP949")
#print(type(raw_data2)
#data_rental.columns = ["gu", "bunho", "name", "x_value", "y_value"]
data_rental = data_rental.dropna(axis=0)
#print(data_rental.tail())

# 대여소-공원 간 거리 계산
data = []
print("엑셀 저장 작업 시작...")
for i in range(0, len(data_rental)):
    loc_rental = [data_rental["x"][i], data_rental["y"][i]]
    
    min1 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_park["x"][0], data_park["y"][0])          
    min2 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_pop["x"][0], data_pop["y"][0])          
    min3 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_river["x"][0], data_river["y"][0])          
    min4 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_road["x"][0], data_road["y"][0])          
    min5 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_univ["x"][0], data_univ["y"][0])      
       
    count = 0
    sum = 0
    
    for a in range(0, len(data_park)):
        d1 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_park["x"][a], data_park["y"][a])
        if d1 < min1:
            min1 = d1            
        
    for a in range(0, len(data_pop)):
        d2 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_pop["x"][a], data_pop["y"][a])
        if d2 < min2:
            min2 = d2 
        
    for a in range(0, len(data_river)):
        d3 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_river["x"][a], data_river["y"][a])
        if d3 < min3:
            min3 = d3 
        
    for a in range(0, len(data_road)):
        d4 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_road["x"][a], data_road["y"][a])
        if d4 < min4:
            min4 = d4 
        
    for a in range(0, len(data_univ)):
        d5 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_univ["x"][a], data_univ["y"][a])
        if d5 < min5:
            min5 = d5         
    
    for a in range(0, len(data_people)):
        d6 = GeoUtil.get_harversion_distance(data_rental["x"][i], data_rental["y"][i], data_people["x"][a], data_people["y"][a])
        if d6 < 1.5:
            sum += data_people["count"][a]
            count += 1
        
    if(count ==0):
            sum = 1
            count=1
    
    people = sum/count

    
    print("대여소명: ", data_rental["name"][i], ", 근접공원: ", min1, ", 근접관광지: ", min2, 
          ", 근접강가:", min3, ", 근접 자전거도로: ", min4, ", 근접대학교:", min5, ", 근접유동인구 평균: ",  people)
    makeExcel(data_rental["name"][i], min1, min2, min3, min4, min5,  people)
print("엑셀로 저장 완료")