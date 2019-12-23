### dealing with the NAs
setwd("c:/Users/user/Desktop/Bundas")
df<-read.csv("bundas_train.csv",na.strings=c(" ","NA",""))
ts<-read.csv("bundas_test.csv",na.strings=c(" ","NA",""))

## in the training set-----
colSums(is.na(df))

## we discovered there are blanks in the weight (1463) collum and the store size (2410). After a deeper analysis we discovered that some of the missing entries for weights collumn have the same item idea as the products with the weight entries hence we decided to fill up the entries with blanks considering their item idea

df$tracker<-1:nrow(df)

## getting columns with the weight entries
drna<-df[complete.cases(df$Weight),]

tra<-drna$tracker

# the entries without any weight entries
dropd<-df[-tra,]

## confirming the combined splits are the same as the original data
nrow(drna)+nrow(dropd)
nrow(df)


colSums(is.na(drna))

weigts<-drna %>% 
  group_by(Item_ID,Weight) %>% 
  summarise(x=1)

colnames(weigts)<-c("Item_ID","Weight_al","x")
compwight<-left_join(dropd, weigts[,-3], by="Item_ID")

compwight$Weight<-compwight$Weight_al

## see only 4 products do not have their weights
colSums(is.na((compwight)))

## combining the two to create a new data set
cmw_df<-rbind(drna,compwight[,-14])

## looking at the size column to determine way of replacing the blanks

stor<-cmw_df[complete.cases(cmw_df$Store_Size),]
instor<-cmw_df[complete.cases(cmw_df$Store_Size)==FALSE,]


nrow(stor)+nrow(instor)
nrow(df)

totll<-sum(df$Item_Store_Sales)

## looking at the percentage of sales accounted for by all the stores
aSTORES<-df %>% 
  group_by(df$Store_ID,df$Store_Establishment_Year,df$Store_Type,df$Store_Location_Type) %>% 
  summarise(total=sum(Item_Store_Sales)) %>% 
  mutate(per=(total/aass)*100)



## looking at the percentage of sales accounted for by the three stores with missing size
bSTORES<-instor %>% 
  group_by(Store_ID,Store_Establishment_Year,Store_Type,Store_Location_Type) %>% 
  summarise(x=sum(Item_Store_Sales)) %>% 
  mutate(per=(x/aass)*100)

## looking at the percentage of sales accounted for by the sevenstores with the size indicated
cSTORES<-stor %>% 
  group_by(Store_ID,Store_Establishment_Year,Store_Type,Store_Location_Type,Store_Size) %>% 
  summarise(total=sum(Item_Store_Sales)) %>% 
  mutate(per=(total/aass)*100)

##we decide to drop it, in doing so we loose 28.32% of our original test data which accounts for 23% of our sales 
fin_df<-cmw_df[complete.cases(cmw_df),]
sum(bSTORES$per)
(1-nrow(fin_df)/nrow(df))*100

write.csv(fin_df,"comp_bundas_train.csv")

## in the test set----
colSums(is.na(ts))

## we discovered there are blanks in the weight (976) collum and the store size (1606). After a deeper analysis we discovered that some of the missing entries for weights collumn have the same item idea as the products with the weight entries hence we decided to fill up the entries with blanks considering their item idea

ts$tracker<-1:nrow(ts)

## getting columns with the weight entries
drna<-ts[complete.cases(ts$Weight),]

tra<-drna$tracker

# the entries without any weight entries
dropd<-ts[-tra,]

## confirming the combined splits are the same as the original data
nrow(drna)+nrow(dropd)
nrow(ts)


colSums(is.na(drna))

weigts<-drna %>% 
  group_by(Item_ID,Weight) %>% 
  summarise(x=1)

colnames(weigts)<-c("Item_ID","Weight_al","x")
compwight<-left_join(dropd, weigts[,-3], by="Item_ID")

compwight$Weight<-compwight$Weight_al

## see only 20 entries do not have their weights replaced
colSums(is.na((compwight)))

sdf<-compwight[complete.cases(compwight)==FALSE,]
## combining the two to create a new data set
cmw_ts<-rbind(drna,compwight[,-c(13)])

##we decide to drop the entries that still have empty entries leading to loose of 28.62%
fin_ts<-cmw_ts[complete.cases(cmw_ts),]
(1-nrow(fin_ts)/nrow(ts))*100

colSums(is.na(fin_ts))

write.csv(fin_ts,"comp_bundas_test.csv.csv")

