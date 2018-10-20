library(randomForest)
setwd("C:/software/part1")

#train <- read.csv('Train.csv', header = TRUE, nrows=1000, row.names = 1)
#test <- read.csv('Test.csv', header = TRUE, nrows=1000, row.names = 1)

train <- read.csv('Train.csv', header = TRUE, colClasses = c("sessionId"="character"))
test <- read.csv('Test.csv', header = TRUE, colClasses = c("sessionId"="character"))

rem_col <- c('adContent', 'adwordsClickInfo.adNetworkType', 'adwordsClickInfo.gclId', 'adwordsClickInfo.isVideoAd', 'adwordsClickInfo.page', 'adwordsClickInfo.slot', 'campaign', 'keyword', 'metro')
train <- train[, ! names(train) %in% rem_col ]
train$purchased <- rep(NA, nrow(train))
train[train$revenue > 0, ]$purchased <- 1
train[train$revenue <= 0, ]$purchased <- 0
train <- train[, !(colnames(train) == 'revenue')]

test <- test[, ! names(test) %in% rem_col ]

# remove columns that have missing values
train <- train[, !colSums(is.na(train))]
test <- test[, !colSums(is.na(test))]

train[, ] <- lapply(train[, ], unclass)
test[, ] <- lapply(test[, ], unclass)
train$purchased <- as.factor(train$purchased)

rf_mod <- randomForest(purchased ~ ., data = train[, -c(1,2)], mtry = 5, importance = TRUE)
rf_mod


test$predictions <- predict(rf_mod, test[, -c(1,2)], type="class")
non_duplicate <- test[!duplicated(test[, 1]), c(1, 26)]
write.csv(non_duplicate, file="predictedv2.csv")
