/*
  Warnings:

  - You are about to drop the column `commentsId` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `likes` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `postsId` on the `Like` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "_LikeToPost" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_LikeToPost_A_fkey" FOREIGN KEY ("A") REFERENCES "Like" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_LikeToPost_B_fkey" FOREIGN KEY ("B") REFERENCES "Post" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_CommentToLike" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_CommentToLike_A_fkey" FOREIGN KEY ("A") REFERENCES "Comment" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CommentToLike_B_fkey" FOREIGN KEY ("B") REFERENCES "Like" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Like" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "usersId" INTEGER NOT NULL,
    CONSTRAINT "Like_usersId_fkey" FOREIGN KEY ("usersId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Like" ("id", "usersId") SELECT "id", "usersId" FROM "Like";
DROP TABLE "Like";
ALTER TABLE "new_Like" RENAME TO "Like";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_LikeToPost_AB_unique" ON "_LikeToPost"("A", "B");

-- CreateIndex
CREATE INDEX "_LikeToPost_B_index" ON "_LikeToPost"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CommentToLike_AB_unique" ON "_CommentToLike"("A", "B");

-- CreateIndex
CREATE INDEX "_CommentToLike_B_index" ON "_CommentToLike"("B");
