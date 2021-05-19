import csv
import datajoint as dj


schema = dj.schema("group_shared_datajoint_example")

@schema
class Pantheon(dj.Lookup):
    definition = """
    pantheon : varchar(16)
    ---
    earliest : int
    latest: int
    """

@schema
class Deity(dj.Manual):
    definition = """
    name : varchar(16)
    ---
    -> Pantheon
    gender : enum('m','f')
    
    """
    
@schema
class Attribute(dj.Manual):
    definition = """
    -> Deity
    attribute : varchar(16)
    """

if __name__ == "__main__":
    kwargs = {"skip_duplicates":True}
    contents = (
            ("_pantheons.csv", ("pantheon", "earliest", "latest"), Pantheon),
            ("_gods.csv", ("name", "gender", "pantheon"), Deity),
            ("_attributes.csv", ("name", "attribute"), Attribute),
            )
    for (file, header, table) in contents:
        with open(file, "r") as f:
            cr = csv.reader(f)
            table.insert([dict(zip(header, row)) for row in cr], **kwargs)
