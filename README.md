# 🏡 Boston House Price Prediction & Deployment

This project involves predicting house prices in **Boston** using **Linear Regression** and deploying the trained model using **Google Cloud Run**. 🚀

---

## 📌 Project Overview

1. **🔍 Data Preprocessing**
   - Loaded the **Boston House Pricing** dataset.
   - Handled **missing values** and structured the dataset.
   - Standardized the features using `StandardScaler`.

2. **📊 Model Training**
   - Used a **Linear Regression** model from `sklearn`.
   - Split data into **training and testing** sets.
   - Evaluated performance using **MAE, MSE, RMSE, and R² score**.

3. **🚀 Model Deployment**
   - Saved the trained model using **Pickle**.
   - Created a **Docker** container for deployment.
   - Deployed it to **Google Cloud Run** using **GitHub Actions**.

---

## 🛠️ Technologies Used

- **🐍 Python**: Pandas, NumPy, Matplotlib, Seaborn, Scikit-Learn
- **🗂️ Pickle**: Model serialization
- **🐳 Docker**: Containerization
- **🤖 GitHub Actions**: CI/CD automation
- **☁️ Google Cloud Run**: Scalable deployment

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

```sh
 git clone https://github.com/Shubham9975/End_To_End_ML_Project_deployment.git
 cd End_To_End_ML_Project_deployment
```

### 2️⃣ Create a Virtual Environment (Optional but Recommended)

```sh
 python -m venv venv
 venv\Scripts\activate  # On Windows
```

### 3️⃣ Install Dependencies

```sh
 pip install -r requirements.txt
```

### 4️⃣ Run the Model Locally

```sh
Boston House Price Pred.ipynb  # Runs data preprocessing and model training
```

**📝 Note:** `.pkl` files are generated after running the model locally, so they are optional initially.

---

## ☁️ Pre-Deployment Actions on GCP

Before running your **GitHub Actions** workflow, ensure everything is set up on **Google Cloud Platform (GCP)**.

### ✅ 1. Enable Required APIs

Run these commands in **Windows Command Prompt**:

```cmd
gcloud services enable run.googleapis.com ^
    cloudbuild.googleapis.com ^
    artifactregistry.googleapis.com ^
    iam.googleapis.com
```

### ✅ 2. Create an Artifact Registry Repository

```cmd
gcloud artifacts repositories create ml-app ^
    --location=us-central1 ^
    --repository-format=docker
```

### ✅ 3. Assign IAM Permissions to Service Account

```cmd
gcloud projects add-iam-policy-binding <YOUR_PROJECT_ID> ^
    --member="serviceAccount:YOUR_SERVICE_ACCOUNT_EMAIL" ^
    --role="roles/editor"

gcloud projects add-iam-policy-binding <YOUR_PROJECT_ID> ^
    --member="serviceAccount:YOUR_SERVICE_ACCOUNT_EMAIL" ^
    --role="roles/run.admin"

gcloud projects add-iam-policy-binding <YOUR_PROJECT_ID> ^
    --member="serviceAccount:YOUR_SERVICE_ACCOUNT_EMAIL" ^
    --role="roles/artifactregistry.writer"
```

### ✅ 4. Create and Retrieve GCP Secrets

#### 🔑 Get Service Account Key (`GCP_SA_KEY`)

```cmd
gcloud iam service-accounts keys create gcp-sa-key.json ^
    --iam-account=YOUR_SERVICE_ACCOUNT_EMAIL
```

#### 📌 Read the Key File and Copy Contents

```cmd
type gcp-sa-key.json
```

Store this in **GitHub Actions secrets** as `GCP_SA_KEY`.

#### 🔍 Retrieve Project ID (`GCP_PROJECT_ID`)

```cmd
gcloud config get-value project
```

#### 🔍 Retrieve Cloud Run Service Name (`GCP_CLOUD_RUN_SERVICE`)

```cmd
gcloud run services list --format="value(metadata.name)"
```

### ✅ 5. Store Secrets in GitHub Actions

Go to **GitHub → Repo → Settings → Secrets → Actions** and add the following secrets:

| Secret Name             | Value                                       |
| ----------------------- | ------------------------------------------- |
| `GCP_SA_KEY`            | Content of `gcp-sa-key.json` file           |
| `GCP_PROJECT_ID`        | Output of `gcloud config get-value project` |
| `GCP_CLOUD_RUN_SERVICE` | Output of `gcloud run services list`        |

### ✅ 6. Create a Cloud Run Service (Optional)

```cmd
gcloud run deploy my-ml-app ^
    --image us-central1-docker.pkg.dev/<YOUR_PROJECT_ID>/ml-app/ml-container:latest ^
    --region us-central1 ^
    --platform managed ^
    --allow-unauthenticated
```

### ✅ 7. Authenticate Docker with Artifact Registry

```cmd
gcloud auth configure-docker us-central1-docker.pkg.dev
```

### ✅ 8. Run the Workflow

Now push a commit to `main` to trigger **GitHub Actions**:

```cmd
git add .
git commit -m "🚀 Deploy ML app to Cloud Run"
git push origin main
```

---

## 🗑️ Delete Services in GCP

To remove the **Cloud Run service**:

```cmd
gcloud run services delete my-ml-app --region=us-central1 --quiet
```

To delete the **Artifact Registry repository**:

```cmd
gcloud artifacts repositories delete ml-app --location=us-central1 --quiet
```

To revoke **IAM policy bindings**:

```cmd
gcloud projects remove-iam-policy-binding <YOUR_PROJECT_ID> ^
    --member="serviceAccount:YOUR_SERVICE_ACCOUNT_EMAIL" ^
    --role="roles/run.admin"
```

---

### 🚀 Happy Coding & Predicting! 🏡✨

