/*
  Warnings:

  - You are about to drop the `_CommentToLike` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_LikeToPost` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropIndex
DROP INDEX "_CommentToLike_B_index";

-- DropIndex
DROP INDEX "_CommentToLike_AB_unique";

-- DropIndex
DROP INDEX "_LikeToPost_B_index";

-- DropIndex
DROP INDEX "_LikeToPost_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_CommentToLike";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_LikeToPost";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Like" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "postsId" INTEGER,
    "commentsId" INTEGER,
    "usersId" INTEGER NOT NULL,
    CONSTRAINT "Like_postsId_fkey" FOREIGN KEY ("postsId") REFERENCES "Post" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Like_commentsId_fkey" FOREIGN KEY ("commentsId") REFERENCES "Comment" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Like_usersId_fkey" FOREIGN KEY ("usersId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Like" ("id", "usersId") SELECT "id", "usersId" FROM "Like";
DROP TABLE "Like";
ALTER TABLE "new_Like" RENAME TO "Like";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
