package Logics.Magic
{
   public class TMagic
   {
      
      protected var FMagicID:uint;
      
      protected var FLevel:uint;
      
      protected var FType:uint;
      
      protected var FMagicName:String;
      
      protected var FNeedBlock:uint;
      
      protected var FNeedExp:int;
      
      protected var FExpAll:uint;
      
      protected var FNeedSilver:uint;
      
      protected var FSilverExp:uint;
      
      protected var FNeedGold:uint;
      
      protected var FGoldExp:uint;
      
      protected var FNeedItem:uint;
      
      protected var FItemExp:uint;
      
      protected var FPower:uint;
      
      protected var FAgile:uint;
      
      protected var FIntelligence:uint;
      
      protected var FLife:uint;
      
      protected var FNeedReincarnationLevel:uint;
      
      protected var FNextid:uint;
      
      protected var FCurExp:uint;
      
      protected var FGoldPracticeCount:uint;
      
      protected var FZhongGoldPracticeCount:uint;
      
      protected var FHouGoldPracticeCount:uint;
      
      protected var FQuanGoldPracticeCount:uint;
      
      protected var FAtrributes:Vector.<uint>;
      
      public function TMagic()
      {
         super();
         this.FAtrributes = new Vector.<uint>();
         this.FMagicName = "";
      }
      
      public function get MagicID() : uint
      {
         return this.FMagicID;
      }
      
      public function set MagicID(param1:uint) : void
      {
         this.FMagicID = param1;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get NeedBlock() : uint
      {
         return this.FNeedBlock;
      }
      
      public function set NeedBlock(param1:uint) : void
      {
         this.FNeedBlock = param1;
      }
      
      public function get NeedExp() : int
      {
         return this.FNeedExp;
      }
      
      public function set NeedExp(param1:int) : void
      {
         this.FNeedExp = param1;
      }
      
      public function get NeedSilver() : uint
      {
         return this.FNeedSilver;
      }
      
      public function set NeedSilver(param1:uint) : void
      {
         this.FNeedSilver = param1;
      }
      
      public function get SilverExp() : uint
      {
         return this.FSilverExp;
      }
      
      public function set SilverExp(param1:uint) : void
      {
         this.FSilverExp = param1;
      }
      
      public function get NeedGold() : uint
      {
         return this.FNeedGold;
      }
      
      public function set NeedGold(param1:uint) : void
      {
         this.FNeedGold = param1;
      }
      
      public function get GoldExp() : uint
      {
         return this.FGoldExp;
      }
      
      public function set GoldExp(param1:uint) : void
      {
         this.FGoldExp = param1;
      }
      
      public function get NeedItem() : uint
      {
         return this.FNeedItem;
      }
      
      public function set NeedItem(param1:uint) : void
      {
         this.FNeedItem = param1;
      }
      
      public function get ItemExp() : uint
      {
         return this.FItemExp;
      }
      
      public function set ItemExp(param1:uint) : void
      {
         this.FItemExp = param1;
      }
      
      public function get Power() : uint
      {
         return this.FPower;
      }
      
      public function set Power(param1:uint) : void
      {
         this.FPower = param1;
      }
      
      public function get Agile() : uint
      {
         return this.FAgile;
      }
      
      public function set Agile(param1:uint) : void
      {
         this.FAgile = param1;
      }
      
      public function get Intelligence() : uint
      {
         return this.FIntelligence;
      }
      
      public function set Intelligence(param1:uint) : void
      {
         this.FIntelligence = param1;
      }
      
      public function get Life() : uint
      {
         return this.FLife;
      }
      
      public function set Life(param1:uint) : void
      {
         this.FLife = param1;
      }
      
      public function set NeedReincarnationLevel(param1:uint) : void
      {
         this.FNeedReincarnationLevel = param1;
      }
      
      public function get NeedReincarnationLevel() : uint
      {
         return this.FNeedReincarnationLevel;
      }
      
      public function get Nextid() : uint
      {
         return this.FNextid;
      }
      
      public function set Nextid(param1:uint) : void
      {
         this.FNextid = param1;
      }
      
      public function get MagicName() : String
      {
         return this.FMagicName;
      }
      
      public function set MagicName(param1:String) : void
      {
         this.FMagicName = param1;
      }
      
      public function get CurExp() : uint
      {
         return this.FCurExp;
      }
      
      public function set CurExp(param1:uint) : void
      {
         this.FCurExp = param1;
      }
      
      public function get Atrributes() : Vector.<uint>
      {
         return this.FAtrributes;
      }
      
      public function set Atrributes(param1:Vector.<uint>) : void
      {
         this.FAtrributes = param1;
      }
      
      public function get GoldPracticeCount() : uint
      {
         return this.FGoldPracticeCount;
      }
      
      public function set GoldPracticeCount(param1:uint) : void
      {
         this.FGoldPracticeCount = param1;
      }
      
      public function get ZhongGoldPracticeCount() : uint
      {
         return this.FZhongGoldPracticeCount;
      }
      
      public function set ZhongGoldPracticeCount(param1:uint) : void
      {
         this.FZhongGoldPracticeCount = param1;
      }
      
      public function get HouGoldPracticeCount() : uint
      {
         return this.FHouGoldPracticeCount;
      }
      
      public function set HouGoldPracticeCount(param1:uint) : void
      {
         this.FHouGoldPracticeCount = param1;
      }
      
      public function get QuanGoldPracticeCount() : uint
      {
         return this.FQuanGoldPracticeCount;
      }
      
      public function set QuanGoldPracticeCount(param1:uint) : void
      {
         this.FQuanGoldPracticeCount = param1;
      }
      
      public function get ExpAll() : uint
      {
         return this.FExpAll;
      }
      
      public function set ExpAll(param1:uint) : void
      {
         this.FExpAll = param1;
      }
   }
}

