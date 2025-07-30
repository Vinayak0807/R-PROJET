# Install required packages (do this once)
install.packages(c("titanic", "dplyr", "ggplot2", "randomForest"))

# Load libraries
library(titanic)
library(dplyr)
library(ggplot2)
library(randomForest)

# Load Titanic dataset
data <- titanic::titanic_train

# Preview data
head(data)

# Clean and prepare data
clean_data <- data %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare, Embarked) %>%
  filter(!is.na(Age), !is.na(Embarked)) %>%
  mutate(Sex = as.factor(Sex),
         Embarked = as.factor(Embarked),
         Survived = as.factor(Survived),
         Pclass = as.factor(Pclass))

# Summary
summary(clean_data)

# Visualization: Survival by Gender
ggplot(clean_data, aes(x = Sex, fill = Survived)) +
  geom_bar(position = "dodge") +
  labs(title = "Survival by Gender", x = "Gender", y = "Count")

# Train a Random Forest model
set.seed(42)
model <- randomForest(Survived ~ ., data = clean_data, ntree = 100, importance = TRUE)

# Model Summary
print(model)

# Variable Importance Plot
varImpPlot(model)

# Predict on training data
predictions <- predict(model, clean_data)

# Confusion Matrix
table(Predicted = predictions, Actual = clean_data$Survived)








