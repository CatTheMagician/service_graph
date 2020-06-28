const axios = require("axios").default;

export async function graph() {
  try {
    const response = await axios.get("api/graph");
    return response;
  } catch (error) {
    console.error(error);
    return null;
  }
}
