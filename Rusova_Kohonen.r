install.packages('kohonen')
library('kohonen')

base <- read.csv(file = "leafshape.csv", header = TRUE)

type <- base[ , -c (1:9)]
leaf <- base[ , -10]

set.seed(1)

som.leaf <-som(scale(leaf), grid = somgrid(5,5, 'hexagonal'))
som.leaf

plot(som.leaf, main = 'leaf kohonen')
plot(som.leaf, type = 'changes', main = 'changes')

#разделение на тестовый и обучающий блоки (80 и 20/70 и 30)
train <-sample(nrow(leaf), 227) #nrow - число строк
train

x_train <- scale(leaf[train,])
x_test <- scale(leaf[-train,], center = attr(x_train, 'scaled:center'), scale = attr(x_train, 'scaled:center'))
type

train_data <-list (measurements = x_train, type = type [train])
test_data <-list (measurements = x_test, type = type [-train])

som_grid <- somgrid (5,5, 'hexagonal')


som.leaf <- supersom(train_data, grid = som_grid)
plot(som.leaf, main = 'Leaf data Kohonen SOM')

som_predict <- predict(som.leaf, newdata = test_data)

som_predict$predictions

table(type[-train], som_predict$predictions[['type']])

classif<- data.frame(type = type [train], class = som.leaf [['unit.classif']])

map(som.leaf)

