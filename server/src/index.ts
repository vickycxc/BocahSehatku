import authRoutes from "./routes/auth.route.js";
import express from "express";
import { config } from "dotenv";

config();
const app = express();
const port = process.env.PORT;
app.use(express.json({ limit: "10mb" }));
app.use(express.urlencoded({ limit: "10mb", extended: true }));
app.use("/api/auth", authRoutes);
app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
