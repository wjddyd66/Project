library(readxl)
library(xlsx)
data = read_excel('C:/R/Data.xlsx')


#Z변환으로 정규화 후 Data 저장
data$People <- scale(data$People)
data$Univ <- scale(data$Univ)
data$Park <- scale(data$Park)
data$Road <- scale(data$Road)
data$River <- scale(data$River)
data$Popular <- scale(data$Popular)

write.xlsx(data,'C:/R/Z_Data.xlsx')


#[0-1]변환으로 정규화 후 Data 저장
data$People <- (data$People-min(data$People))/(max(data$People)-min(data$People))
data$Univ <- (data$Univ-min(data$Univ))/(max(data$Univ)-min(data$Univ))
data$Park <- (data$Park-min(data$Park))/(max(data$Park)-min(data$Park))
data$Road <- (data$Road-min(data$Road))/(max(data$Road)-min(data$Road))
data$River <- (data$River-min(data$River))/(max(data$River)-min(data$River))
data$Popular <- (data$Popular-min(data$Popular))/(max(data$Popular)-min(data$Popular))

write.xlsx(data,'C:/R/X_Data.xlsx')