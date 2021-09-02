### Installation of necessary packages and libraries
install.packages("neuralnet")
install.packages('nnet')
require(neuralnet)

### Read in Data 
setwd("/Users/eesos/OneDrive/Desktop/MIS 545/Project")
getwd()
vgsales <- read.csv("vgsalescleaned.csv")
str(vgsales)


### Convert Platform and Genre to factor 
vgsales$Platform<-as.factor(vgsales$Platform)
vgsales$Publisher

vgsales$Publisher<-as.factor(vgsales$Publisher)

vgsales$Genre<-as.factor(vgsales$Genre)
vgsales$Genre

str(vgsales$Genre)

### Create dummy variables for Platform and Genre and create dataframe for NN 
dumvargenre <- nnet::class.ind(vgsales$Genre)

dumvarplatform <- nnet::class.ind(vgsales$Platform)

varglobalsales <- (vgsales$Global_Sales)

vgsalesNN <- data.frame(dumvargenre, dumvarplatform,varglobalsales)

vgsalesNN


### take 60% as training set
sample_size <- floor(0.6 * nrow(vgsalesNN))

###   randomly decide which ones are training data
training_index <- sample(nrow(vgsalesNN), size = sample_size, replace = FALSE)

train <- vgsalesNN[training_index,]
test <- vgsalesNN[-training_index,]

names(vgsalesNN)

### Neural Network
nn <- neuralnet(varglobalsales ~ dumvargenre + dumvarplatform, data=train, hidden=2, startweights=NULL, act.fct="logistic", linear.output=FALSE)

plot(nn)