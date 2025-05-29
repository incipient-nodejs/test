import express from "express";

const app = express();

const PORT = process.env.PORT || 3000;

app.get("/health", (req, res) => {
  res.send("Zindha hai!22");
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
