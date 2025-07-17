import axios from "axios";

async function sendOTP(YOUR_PHONE_NUMBER: string) {
  const data = {
    phone: YOUR_PHONE_NUMBER,
    gateway_key: "3ec4c4f4-6848-47a8-9a61-4fc27e081aeb",
  };

  try {
    const response = await axios.post(
      "https://api.fazpass.com/v1/otp/generate",
      data,
      {
        headers: {
          Authorization:
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWVyIjoxNjQ5M30.3kCok5DIPbcnRg4x05ldXt2RqyNZNNi-lXO4_z5Ncjk",
          "Content-Type": "application/json",
        },
      }
    );

    console.log(JSON.stringify(response.data, null, 2));

    if (response.data.status == true) {
      return "OTP sent successfully!";
    } else {
      return (
        "Error: " +
        (response.data.message || "Something went wrong while requesting OTP.")
      );
    }
  } catch (error: any) {
    console.error("Error sending OTP:", JSON.stringify(error, null));
    return "Error: " + error.message;
  }
}

// Example usage with phone number
const YOUR_PHONE_NUMBER = "04533553";
sendOTP(YOUR_PHONE_NUMBER)
  .then((response) => console.log(response))
  .catch((error) => console.error(error));
