/*
  Warnings:

  - You are about to drop the column `likes` on the `Posts` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "Likes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "likes" INTEGER NOT NULL,
    "postsId" INTEGER,
    "commentsId" INTEGER,
    CONSTRAINT "Likes_postsId_fkey" FOREIGN KEY ("postsId") REFERENCES "Posts" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Likes_commentsId_fkey" FOREIGN KEY ("commentsId") REFERENCES "Comments" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Posts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "usersId" INTEGER NOT NULL,
    CONSTRAINT "Posts_usersId_fkey" FOREIGN KEY ("usersId") REFERENCES "Users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Posts" ("id", "message", "title", "usersId") SELECT "id", "message", "title", "usersId" FROM "Posts";
DROP TABLE "Posts";
ALTER TABLE "new_Posts" RENAME TO "Posts";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
