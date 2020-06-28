const axios = require("axios").default;

export async function servicesList() {
  try {
    const response = await axios.get("api/services");
    return response;
  } catch (error) {
    console.error(error);
    return null;
  }
}

export async function service(title) {
  try {
    const response = await axios.get(
      "http://localhost:4000/api/services/" + title
    );
    return response;
  } catch (error) {
    console.error(error);
    return null;
  }
}
export async function deleteService(title) {
  try {
    const response = await axios.delete(
      "http://localhost:4000/api/services/" + title
    );
    return response;
  } catch (error) {
    console.error(error);
    return null;
  }
}
