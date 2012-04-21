# This class is responsible for creating all the objects in the database
# given an Upload object. It will also be responsible for recording when
# the Upload started being processed and when it finished.
#
# This should really be run in the background. The data in this example
# is probably unrepresentative and I would assume the data needing to be
# imported is going to be much larger and take a signicant amount of
# time to process.
# Thus, I will use Resque to process the import tasks in the background.
class Importer

end
