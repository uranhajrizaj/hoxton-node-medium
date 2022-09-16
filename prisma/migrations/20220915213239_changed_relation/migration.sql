/*
  Warnings:

  - You are about to drop the `_CommentToPost` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropIndex
DROP INDEX "_CommentToPost_B_index";

-- DropIndex
DROP INDEX "_CommentToPost_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_CommentToPost";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Comment" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "message" TEXT NOT NULL,
    "usersId" INTEGER NOT NULL,
    "postId" INTEGER,
    CONSTRAINT "Comment_usersId_fkey" FOREIGN KEY ("usersId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Comment_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Comment" ("id", "message", "usersId") SELECT "id", "message", "usersId" FROM "Comment";
DROP TABLE "Comment";
ALTER TABLE "new_Comment" RENAME TO "Comment";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
