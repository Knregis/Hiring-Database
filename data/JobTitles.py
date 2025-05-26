from faker import Faker
from faker.providers import BaseProvider, ElementsType


fake = Faker()

# creating a class so I can generate jobtitle related to 
# the prefix/ suffix of each worker
# these would be the titles they would apply for based on their name
# a docter may apply to be a pathologist 

class JobTitleProvider(BaseProvider):

    pass


