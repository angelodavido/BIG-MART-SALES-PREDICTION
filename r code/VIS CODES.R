setwd("c:/Users/user/Desktop/Bundas")
df<-read.csv("bundas_train.csv",na.strings=c(" ","NA",""))
ts<-read.csv("bundas_test.csv",na.strings=c(" ","NA",""))

library("plyr")##when count command refuses to work dettach the load the package again
library("tidyr")
library("data.table")
library("stringr")
library("dplyr")
library("ggplot2")


levels(df$FatContent)<-c("Low Fat","Low Fat","Low Fat","Regular","Regular")
levels(df$Category)
levels(df$Store_ID)
df$Store_Establishment_Year<-factor(df$Store_Establishment_Year)
levels(df$Store_Establishment_Year)
glimpse(df)

ggplot(df,aes(x=df$,y=df$Item_Store_Sales,fill=))+
  geom_col()+
  labs(title = "EFFECT OF ON ITEM SALES",x="",y="Sales")


## Fat content
a<-ggplot(df,aes(x=df$FatContent,y=df$Item_Store_Sales,fill=FatContent))+
  geom_col()+
  labs(title = "EFFECT OF FAT CONTENT ON SALES",x="Fat content",y="Sales")+
  theme_bw()

ggsave("fat content.png",plot = a,height = 12,width = 10)

## Category
b<-ggplot(df,aes(x=df$Category,y=df$Item_Store_Sales,fill=Category))+
  geom_col()+
  labs(title = "EFFECT OF ITEM CATEGORY ON SALES",x="item Category",y="Sales")+
  theme(axis.text.x = element_text(angle=-60,hjust = 0.2,vjust = 0.2))

ggsave(" category.png",plot =b ,height = 12,width = 10)


## store id
c<-ggplot(df,aes(x=df$Store_ID,y=df$Item_Store_Sales,fill=Store_ID))+
  geom_col()+
  labs(title = "EFFECT OF STORE ID ON SALES",x="Store id",y="Sales")+
  theme(axis.text.x = element_text(angle=-60,hjust = 0.2,vjust = 0.2))

cb<-c+facet_wrap(~df$Store_Type)+labs(subtitle = "While considering Store type")
ggsave("store id.png",plot =c ,height = 12,width = 10)
ggsave("combined store id store type.png",plot =cb ,height = 12,width = 10)

## store establishment year
d<-ggplot(df,aes(x=df$Store_Establishment_Year,y=df$Item_Store_Sales,fill=Store_Establishment_Year))+
  geom_col()+
  labs(title = "EFFECT OF YEAR OF ESTABLISHMENT ON SALES",x="Year of establishment",y="Sales")+
  theme_bw()

ggsave("year of establishment.png",plot =d ,height = 12,width = 10)
d+facet_wrap(~df$Store_ID)

## STORE SIZE
e<-ggplot(df,aes(x=df$Store_Size,y=df$Item_Store_Sales,fill=Store_Size))+
  geom_boxplot()+
  labs(title = "EFFECT OF STORE SIZE ON SALES",x="store size",y="Sales")+
  theme_bw()
e
eb<-e+facet_wrap(~df$Store_Type)+labs(subtitle = "While considering Store type")
ggsave("size of store.png",plot =e ,height = 12,width = 10)
ggsave("combined size of store and store type.png",plot =eb ,height = 12,width = 10)


## STORE LOCATION TYPE
f<-ggplot(df,aes(x=df$Store_Location_Type,y=df$Item_Store_Sales,fill=Store_Location_Type))+
  geom_col()+
  labs(title = "EFFECT OF THE STORE LOCATION TYPE ON SALES",x="store location type",y="Sales")+
  theme_bw()

fb<-f+facet_wrap(~df$Store_Type)+labs(subtitle = "While considering Store type")
ggsave("store location type.png",plot =f,height = 12,width = 10)
ggsave("combined store location type and store type.png",plot =fb,height = 12,width = 10)


### STORE TYPE
g<-ggplot(df,aes(x=df$Store_Type,y=df$Item_Store_Sales,fill=Store_Type))+
  geom_col()+
  labs(title = "EFFECT OF STORE TYPE ON SALES",x="store type",y="Sales")+
  theme(axis.text.x = element_text(angle=-60,hjust = 0.2,vjust = 0.2))

ggsave("store type.png",plot =g ,height = 12,width = 10)

