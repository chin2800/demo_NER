FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Installing required packages
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Installing Jupyter
RUN pip install jupyter

# Copying all source files within directory
COPY . .

# Converting Jupyter notebook to Python script
RUN jupyter nbconvert --to script /app/NERModelV1.ipynb && mv /app/NERModelV1.py /app/ner_model.py

# Uninstalling Jupyter after conversion
RUN pip uninstall -y jupyter && rm /app/NERModelV1.ipynb

# Exposing port
EXPOSE 5000

# Environment variables for Seldon Core
ENV MODEL_NAME NERModel
ENV SERVICE_TYPE MODEL
ENV PERSISTENCE 0

# Running the Seldon Core microservice
CMD ["sh", "-c", "seldon-core-microservice $MODEL_NAME --service-type $SERVICE_TYPE"]
