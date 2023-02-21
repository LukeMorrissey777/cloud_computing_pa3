import random

class DBRouter:
    def db_for_read(self, model, **hints):
        """
        Reads go to a randomly-chosen replica.
        """
        return random.choice(['db1', 'db2'])

    def db_for_write(self, model, **hints):
        """
        Writes  go to randomly chosen replica.
        """
        return random.choice(['db1', 'db2'])

    def allow_relation(self, obj1, obj2, **hints):
        return True

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        return True