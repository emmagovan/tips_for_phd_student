library(devtools)
library(testthat)



# Devtools tests ----------------------------------------------------------
document() # this just updates files like you NAMESPACE (you've probably been already using this)
devtools::test() # if you have any test files (like testThat), this runs the tests (not necessary for CRAN)

# This one actually checks if your package has an errors, warnings, or notes. These ALL need to
# be resolved. CRAN wont publish your package if there's any errors, warnings, or notes
devtools::check(vignettes = F) # vignettes = F doesnt check your vignette and makes this go quicker.

#When using JAGS - you need to save your model code in a separate file, otherwise you'll get errors when
#running code. SAve your JAGS code as a text file within the inst folder (you can make a folder inside this
#for your JAGS files).
#This is the code you want to use:
jags_file <- system.file("name_of_jags_folder_in_inst", "jags_script_name.jags", package = "your_package_name")
output <- R2jags::jags(
    data = data,
    parameters.to.save = c("param1"),
    model.file = jags_file,
    n.chains = mcmc_control$n.chain,
    n.iter = mcmc_control$iter,
    n.burnin = mcmc_control$burn,
    n.thin = mcmc_control$thin
  )



# CRAN checks -------------------------------------------------------------

# Here's where it can get complicated!! Your package gets compiled on different operating systems.
# So, it may compile properly on, say, a Mac... but it may fail on a windows machine...
# Some of these issues can be complicated to fix, or maybe outside of your control to fix.
# After you run some of these checks (which are slow to run), you'll get emailed with a huge log file.
# You have to manually go through the file to find any errors that may exist.
# In some cases, you might get a false-positive error. If that happens, when you submit your package,
# CRAN will reply saying there's an error, and you can reply back saying why you think
# the error is a false positive.

# From the book
usethis::use_news_md()
usethis::use_cran_comments()
devtools::check_mac_release()

# windows tests
check_win_release()
check_win_devel()

# R-hub tests
#rhub::validate_email() --> have issue with email
checkRHUB <- check_rhub()
checkRHUB$cran_summary()
checkRHUB$print()

# cran tests
checkCRAN <- rhub::check_for_cran()
checkCRAN$cran_summary()
checkCRAN$print()



# CRAN submission ---------------------------------------------------------

# This is the function to actually submit your package to CRAN. Only run this
# when everything is fixed and you're happy to submit.
submit_cran()


# Resubmit-------
# The version is no longer 0.900.000 it should be something like 0.1.00







