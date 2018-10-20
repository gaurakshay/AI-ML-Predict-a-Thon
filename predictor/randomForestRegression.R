library(randomForest)
setwd("C:/software/part1")

train <- read.csv('TrainRegression.csv', header = TRUE, colClasses = c("sessionId"="character"))
test <- read.csv('TestRegression.csv', header = TRUE, colClasses = c("sessionId"="character"))

rem_col <- c('adContent', 'adwordsClickInfo.adNetworkType', 'adwordsClickInfo.gclId', 'adwordsClickInfo.isVideoAd', 'adwordsClickInfo.page', 'adwordsClickInfo.slot', 'campaign', 'keyword', 'metro')
train <- train[, ! names(train) %in% rem_col ]

test <- test[, ! names(test) %in% rem_col ]

# remove columns that have missing values
train <- train[, !colSums(is.na(train))]
test <- test[, !colSums(is.na(test))]

train[, ] <- lapply(train[, ], unclass)
test[, ] <- lapply(test[, ], unclass)

rf_mod <- randomForest(revenue ~ ., data = train[, -c(1,2)], mtry = 5, importance = TRUE)

test$predRevenue <- predict(rf_mod, test[, -c(1,2)])
non_duplicate <- test[!duplicated(test$custId), c(1, 26)]
write.csv(non_duplicate, file="predictedRegression.csv", quote = FALSE, row.names = FALSE)
