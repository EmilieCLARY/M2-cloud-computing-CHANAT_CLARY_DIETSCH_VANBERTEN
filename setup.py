
from setuptools import setup, find_packages

setup(
    name="M2-project-cloud-computing",
    version="0.1",
    packages=find_packages(include=['infrastructure', 'infrastructure.*']),
    # ...existing code...
)