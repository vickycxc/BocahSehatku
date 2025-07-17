import jwt from "jsonwebtoken";

interface TokenPayload {
  userId: number;
  role: string;
}

const generateToken = ({ userId, role }: TokenPayload) => {
  return jwt.sign({ userId, role }, process.env.JWT_SECRET || "my_jwt_secret", {
    expiresIn: "7d",
  });
};

export default generateToken;
