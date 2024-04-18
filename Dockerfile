FROM continuumio/miniconda3

# Set the working directory inside the container
WORKDIR /container

# Copy the requirements.txt file into the container at /container
COPY env.yml /container

# Install any dependencies specified in requirements.txt
RUN conda env create --file env.yml -n ml4chem

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "ml4chem", "/bin/bash", "-c"]

# Copy the current directory contents into the container at /container
COPY . /container

# Expose port 8888 to access Jupyter Notebook
EXPOSE 8888

# The code to run when container is started:
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "ml4chem", "python3", "app/test.py"]

# Command to run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
