from faker import Faker
from faker.providers import BaseProvider, ElementsType

  # names: ElementsType[str] = [
    # "{{prefix}} {{first_name}} {{last_name}}",
    # "{{first_name}} {{last_name}} {{suffix}}"
    # ]


fake = Faker()

# creating a class with a prefix and suffix list that will contain
# Words I want randomly before or after the fake names

class MedicalProfessionsProvider(BaseProvider):

    # def_init_(self, prefix_elements, suffix_elements, occupation, Job description, )

    prefix_elements: ElementsType[str] = [
        "Dr.", "Doctor", "Nurse", "Surgeon", "Clerk"
        ]
    
    suffix_elements: ElementsType[str] = [
        "MD", "MD, PhD", "PA", "DO"
        ]

    job_elements: ElementsType[str] = [
        "Registered Nurse", "Assisted Living Nurse", "Emergency Room Nurse",
        "Labor and Delivery Nurse", "Neurologist", "Pediatrician", "General Surgeons",
        "Internists"
    ]
    
    # there are two functions that deal with making the 
    # prefix/suffix appear randomly

    def prefix(self) -> str:
        return self.random_element(self.prefix_elements)

    def first_names(self) -> str:
        f_names = self.random_element(self.first_name)
        return self.generator.parse(f_names)
    

    def last_names(self) -> str:
        l_names = self.random_element(self.last_name)
        return self.generator.parse(l_names)

    def suffix(self) -> str:
        return self.random_element(self.suffix_elements)
    


fake.add_provider(MedicalProfessionsProvider)

data = {
'Prefix': [fake.prefix() for _ in range(56)],
'FirstNames': [fake.first_name for _ in range(56)],
'LastNames': [fake.last_name for _ in range(56)],
'Suffix': [fake.suffix() for _ in range(56)],
'Email' : [fake.email() for _ in range(56)],
'PhoneNumber' : [fake.phone_number() for _ in range(56)],
'Job_Desc': [fake.text() for _ in range(56)]

}