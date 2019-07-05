library(ggplot2)
library(ggmap)
library(xlsx)
library(readxl)
library(dplyr)

#데이터 불러오기
location <- read_excel("location.xlsx",na="NA")
count <- read_excel("count.xlsx",na="NA")
#Column 명 변경
colnames(location) <- c('number','name','x','y')
#Column 숫자로 변경
location$number <- as.numeric(location$number)
location$x <- as.numeric(location$x)
location$y <- as.numeric(location$y)

#Count Data에 x,y좌표 추가
for(i in 1:length(count$number)){
  for(j in 1:length(location$x)){
    if(count$number[i] == location$number[j]){
      count$x[i] <- location$x[j]
      count$y[i] <- location$y[j]
    }
  }
}

#Map을 위한 Data 저장 
write.xlsx(people,file="map.xlsx")

#MapData 불러오기
data<-read_excel("map.xlsx",na="NA")

#MapData 상위 100개, 하위100개 나누기
many <- data[1:100,]
min <- data[length(data$number)-936:length(data$number),]

#GoogleMap Key 등록
register_google(key='개인API')

#GoogleMap 을 활용한 Map그리기
center <- c(mean(data$x),mean(data$y))
seoul <- get_map(center, zoom=11, maptype='roadmap')

#상위 100개 지도에 그리기
ggmap(seoul) + geom_point(data=many,aes(x=x,y=y),size=2.5,alpha=0.8,col='red')

#하위 100개 지도에 그리기
ggmap(seoul) + geom_point(data=min,aes(x=x,y=y),size=2.5,alpha=0.8,col='blue')
