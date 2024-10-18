from flask import Flask, request, render_template
import pickle
import pandas as pd

app = Flask(__name__)

# Load the pre-trained model
model_path = 'model/cbc.pkl'
with open(model_path, 'rb') as model_file:
    model = pickle.load(model_file)

@app.route('/')
def index():
    return render_template('index.html')  # Serve the HTML page

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Collect data from the form
        data = {
            'credit_score': int(request.form.get('credit_score')),
            'age': int(request.form.get('age')),
            'balance': float(request.form.get('balance')),
            'estimated_salary': float(request.form.get('estimated_salary')),
            'num_of_products': int(request.form.get('num_of_products')),
            'has_credit_card': int(request.form.get('has_credit_card')),
            'is_active_member': int(request.form.get('is_active_member')),
            'tenure': int(request.form.get('tenure')),
            'gender': request.form.get('gender'),  # 'Male' or 'Female'
            'geography': request.form.get('geography'),  # 'France', 'Germany', or 'Spain'
        }

        # Create DataFrame for prediction without Surname
        df = pd.DataFrame([{
            'CreditScore': data['credit_score'],
            'Age': data['age'],
            'Balance': data['balance'],
            'EstimatedSalary': data['estimated_salary'],
            'Gender': 1 if data['gender'] == 'Male' else 0,  # Assume binary encoding
            'NumOfProducts': data['num_of_products'],
            'HasCrCard': data['has_credit_card'],
            'Tenure': data['tenure'],
            'IsActiveMember': data['is_active_member'],
            'Geography_France': 1 if data['geography'] == 'France' else 0,
            'Geography_Germany': 1 if data['geography'] == 'Germany' else 0,
            'Geography_Spain': 1 if data['geography'] == 'Spain' else 0,
        }])

        # Ensure the order of features matches the model's training
        feature_order = [
            'CreditScore',
            'Age',
            'Balance',
            'EstimatedSalary',
            'Gender',
            'NumOfProducts',
            'HasCrCard',
            'Tenure',
            'IsActiveMember',
            'Geography_France',
            'Geography_Germany',
            'Geography_Spain'
        ]

        # Reorder DataFrame to match model training order
        df = df[feature_order]

        # Make the prediction
        prediction = model.predict(df)

        result = "Churn" if int(prediction[0]) == 1 else "Not Churn"

        # Pass the prediction back to the template
        return render_template('index.html', prediction_text=f'Prediction: {result}')

    except Exception as e:
        # Handle any exceptions that occur during prediction
        return render_template('index.html', prediction_text=f'Error: {str(e)}')

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=False)
