import { db } from "../server/src/database/db.ts";

const username = "daniel";
const charName = "Uzumaki_Daniel";
const profession = 1; // 1: Lâmina das Trevas / Ninjutsu
const gender = 1;

console.log(`[Seed] Criando conta de teste: ${username}`);
const account = db.getOrCreateAccount(username, "token_daniel_test");
console.log(`[Seed] Conta ID: ${account.id}, Usuário: ${account.user_id}`);

let char = db.getCharacterByAccountId(account.id);
if (!char) {
  char = db.createCharacter(account.id, charName, profession, gender);
  console.log(`[Seed] Personagem criado: "${char.name}" (Nível ${char.level}, ID: ${char.id})`);
} else {
  console.log(`[Seed] Personagem já existente: "${char.name}" (Nível ${char.level}, ID: ${char.id})`);
}

const currency = db.getCurrency(char.id);
console.log(`[Seed] Recursos disponíveis: ${currency.ryo} Ryo, ${currency.gold} Ouro, ${currency.coupons} Cupons.`);

const bag = db.getInventory(char.id);
console.log(`[Seed] Mochila: ${bag.length} itens.`);

const team = db.getTeam(char.id);
console.log(`[Seed] Equipe ninja: ${team.length} membros.`);

console.log("\n[Seed Concluído] Conta e Personagem prontos para jogar!");
