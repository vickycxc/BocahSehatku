import { withAccelerate } from "@prisma/extension-accelerate";
import { PrismaClient } from "../../generated/prisma/index.js";

const prisma = new PrismaClient().$extends(withAccelerate());

export default prisma;
