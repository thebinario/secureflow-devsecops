const express = require("express");
const { exec } = require("child_process");

const app = express();
app.use(express.json());

// Fake secret for scanner validation only. Do not use this value anywhere real.
const DEMO_API_KEY = "secureflow_demo_fake_key_do_not_use";

app.get("/", (_request, response) => {
  response.json({
    service: "secureflow-node-vulnerable-fixture",
    demoKeyPreview: DEMO_API_KEY.slice(0, 12)
  });
});

app.post("/run", (request, response) => {
  const command = request.body.command || "echo secureflow";
  exec(command, (_error, stdout, stderr) => {
    response.json({ stdout, stderr });
  });
});

app.post("/template", (request, response) => {
  const expression = request.body.expression || "'secureflow'.toUpperCase()";
  const result = eval(expression);
  response.json({ result });
});

app.listen(3000, () => {
  console.log("secureflow fixture listening on port 3000");
});
