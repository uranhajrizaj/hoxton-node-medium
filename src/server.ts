import express from "express";
import cors from "cors";
import { Post, PrismaClient } from "@prisma/client";

const app = express();
app.use(cors());
app.use(express.json());
const port = 4456;

const prisma = new PrismaClient({ log: ["warn", "error", "info", "query"] });

//get all users with their posts and likes including comments with likes

app.get("/users", async (req, res) => {
  try {
    const users = await prisma.user.findMany({
      include: {
        posts: {
          include: {
            postlikes: { select: { user: true } },
            comments: {
              select: {
                message: true,
                user: true,
                commentlikes: { select: { user: true } },
              },
            },
          },
        },
      },
    });
    res.send(users);
  } catch (error) {
    //@ts-ignore
    res.send({ error: error.message });
  }
});

//get user by id

app.get("/users/:id", async (req, res) => {
  try {
    const id = Number(req.params.id);
    const user = await prisma.user.findUnique({
      where: { id },
      include: {
        posts: {
          include: {
            postlikes: { select: { user: true } },
            comments: {
              select: {
                message: true,
                user: true,
                commentlikes: { select: { user: true } },
              },
            },
          },
        },
      },
    });
    if (user) res.send(user);
    else res.status(404).send({ error: "User not found." });
  } catch (error) {
    //@ts-ignore
    res.send({ error: error.message });
  }
});

//create new post and get back user with his posts and likes including comments with likes

app.post("/post/:userId", async (req, res) => {
  try {
    const id = Number(req.params.userId);
    const newpost = await prisma.post.create({
      data: {
        title: req.body.title,
        message: req.body.message,
        usersId: id,
      },
      select: {
        user: {
          include: {
            posts: {
              include: {
                postlikes: { select: { user: true } },
                comments: {
                  select: {
                    message: true,
                    user: true,
                    commentlikes: { select: { user: true } },
                  },
                },
              },
            },
          },
        },
      },
    });
    res.send(newpost);
  } catch (error) {
    //@ts-ignore
    res.send({ error: error.message });
  }
});

// like a comment or a post by user

app.post("/postlikes", async (req, res) => {
  try {
    const newpost = await prisma.postLike.create({
      data: {
        postId: req.body.postId,
        userId: Number(req.body.userId),
      },
      include: {
        user: {
          include: {
            posts: {
              include: {
                postlikes: {select:{user:true}},
                comments: { include: { commentlikes: true } },
              },
            },
          },
        },
      },
    });
    res.send(newpost.user);
  } catch (error) {
    //@ts-ignore
    res.send({ error: error.message });
  }
});

app.post("/commentlikes", async (req, res) => {
  try {
    const newpost = await prisma.commentLike.create({
      data: {
        commentId: req.body.commentId,
        userId: Number(req.body.userId),
      },
      include: {},
    });
    res.send(newpost);
  } catch (error) {
    //@ts-ignore
    res.send({ error: error.message });
  }
});

//add a new comment
app.post("/comments", async (req, res) => {
  try {
    const newpost = await prisma.comment.create({
      data: {
        message: req.body.message,
        postId: req.body.postId,
        usersId: Number(req.body.usersId),
      },
    });
    res.send(newpost);
  } catch (error) {
    //@ts-ignore
    res.send({ error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Server is running on: http://localhost:${port}/users`);
});
