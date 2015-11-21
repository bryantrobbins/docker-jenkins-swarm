# I want commands printed in output
options(echo=TRUE)

# Needed for portable installs
cran <- "http://cran.rstudio.com/"
install.packages("glmnet", repos=cran)
install.packages("methods", repos=cran)
install.packages("mda", repos=cran)
install.packages("rmongodb", repos=cran)
install.packages("data.table", repos=cran)
install.packages("ROCR", repos=cran)
install.packages("devtools", repos=cran)
require(devtools)
install_github("Gastrograph/RS3")
