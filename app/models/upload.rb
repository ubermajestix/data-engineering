# This class will store the uploaded import data. We also probably want
# to know when it was uploaded, when it started getting processed and
# when it finished getting processed.
#
# In reality these files are going to be large so being able to see how
# fast (or slow) previous files have been processed would give us a
# good idea on how long it will take to process new files.
# This information could be useful to us when we want to refactor
# and attempt to make things faster. We would then have a benchmark to
# measure our, hopefully, improved processing code against.
class Upload

end
