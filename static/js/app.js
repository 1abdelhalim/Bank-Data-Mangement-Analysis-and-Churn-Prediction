document.getElementById('predictionForm').addEventListener('submit', function (event) {
    // Get form fields
    const creditScore = document.getElementById('credit_score').value;
    const age = document.getElementById('age').value;
    const balance = document.getElementById('balance').value;
    const estimatedSalary = document.getElementById('estimated_salary').value;
    const numOfProducts = document.getElementById('num_of_products').value;
    const hasCreditCard = document.getElementById('has_credit_card').value;
    const isActiveMember = document.getElementById('is_active_member').value;
    const tenure = document.getElementById('tenure').value;

    // Validate the form
    if (creditScore < 300 || creditScore > 850) {
        alert('Credit score must be between 300 and 850.');
        event.preventDefault(); // Prevent form submission
    }

    if (age < 18 || age > 100) {
        alert('Age must be between 18 and 100.');
        event.preventDefault();
    }

    if (balance < 0 || balance > 1000000) {
        alert('Balance must be between 0 and 1,000,000.');
        event.preventDefault();
    }

    if (estimatedSalary < 0 || estimatedSalary > 500000) {
        alert('Estimated salary must be between 0 and 500,000.');
        event.preventDefault();
    }

    if (numOfProducts < 1 || numOfProducts > 4) {
        alert('Number of products must be between 1 and 4.');
        event.preventDefault();
    }

    if (hasCreditCard != 0 && hasCreditCard != 1) {
        alert('Has credit card must be 1 (Yes) or 0 (No).');
        event.preventDefault();
    }

    if (isActiveMember != 0 && isActiveMember != 1) {
        alert('Is active member must be 1 (Yes) or 0 (No).');
        event.preventDefault();
    }

    if (tenure < 0 || tenure > 10) {
        alert('Tenure must be between 0 and 10 years.');
        event.preventDefault();
    }
});
