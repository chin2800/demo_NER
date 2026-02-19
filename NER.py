import spacy

# Adjust the path to where your model is located
model_path = "C:\LW_NER\app"  # This should be the path to your model’s main directory

# Load the pre-trained model
nlp = spacy.load(model_path)

# Test the model with a sample text
text = "Lucidworks is based in California"
doc = nlp(text)

# Print out recognized entities
for ent in doc.ents:
    print(ent.text, ent.label_)
