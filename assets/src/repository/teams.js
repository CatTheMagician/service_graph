const axios = require("axios").default;

export async function teamsList() {
  try {
    const response = await axios.get("api/teams");
    return response;
  } catch (error) {
    console.error(error);
    return null;
  }
}
export async function getTeam(id) {
  try {
    const response = await axios.get("/api/teams/" + id);
    return response;
  } catch (error) {
    console.error(error);
    return null;
  }
}

export async function updateTeam(id, title, color, services) {
  try {
    const response = await axios.post(
      "/api/teams/" + id,
      {
        title: title,
        color: color,
        services: services,
      },
      {}
    );
    return response;
  } catch (error) {
    console.error(error);
    return null;
  }
}
export async function createTeam(id, title, color, services) {
  try {
    const response = await axios.post(
      "/api/teams/create",
      {
        title: title,
        color: color,
        services: services,
      },
      {}
    );
    return response;
  } catch (error) {
    console.error(error);
    return null;
  }
}
