package Foundation.Resources
{
   import Foundation.LoaderQueue.SLoaderProgress;
   import Foundation.Resources.Common.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.Agent.SParametersCore;
   import Resources.Strings.STRING_ERROR;
   
   use namespace ResourcesSpace;
   
   public class TResourcesCore
   {
      
      protected var FRepositories:Vector.<TResourceRepository>;
      
      protected var FRepositorieTextures:Vector.<TResourceRepositoryTexture>;
      
      protected var FTexturesSwfVital:TResourceRepositorySwf;
      
      protected var FTexturesSwfCommon:TResourceRepositorySwf;
      
      protected var FTexturesSwfCreateChar:TResourceRepositorySwf;
      
      protected var FTexturesSwfChat:TResourceRepositorySwf;
      
      protected var FTexturesSwfBattle:TResourceRepositorySwf;
      
      protected var FTexturesSwfLobby:TResourceRepositorySwf;
      
      protected var FTexturesSwfFont:TResourceRepositorySwf;
      
      protected var FTexturesSwfPlot:TResourceRepositorySwf;
      
      protected var FTexturesSwfSkill:TResourceRepositorySwf;
      
      protected var FTexturesTryout:TResourceRepositoryTexture;
      
      protected var FTexturesFollowBloodBound:TResourceRepositoryTexture;
      
      protected var FTexturesVital:TResourceRepositoryTexture;
      
      protected var FTexturesLobby:TResourceRepositoryTexture;
      
      protected var FTexturesModel:TResourceRepositoryTexture;
      
      protected var FTexturesSkillIcon:TResourceRepositoryTexture;
      
      protected var FTexturesLargeIcon:TResourceRepositoryTexture;
      
      protected var FTexturesSmallIcon:TResourceRepositoryTexture;
      
      protected var FTexturesPet:TResourceRepositoryTexture;
      
      protected var FTexturesHeadIcon:TResourceRepositoryTexture;
      
      protected var FTexturesMiddlePic:TResourceRepositoryTexture;
      
      protected var FTexturesBackgroundIcon:TResourceRepositoryTexture;
      
      protected var FTexturesInventory:TResourceRepositoryTexture;
      
      protected var FTexturesBuffIcon:TResourceRepositoryTexture;
      
      protected var FTexturesDailytaskPicture:TResourceRepositoryTexture;
      
      protected var FTexturesPreview:TResourceRepositoryTexture;
      
      protected var FTexturesUserTitle:TResourceRepositoryTexture;
      
      protected var FTexturesFettersSmall:TResourceRepositoryTexture;
      
      protected var FTexturesFettersBig:TResourceRepositoryTexture;
      
      protected var FTexturesNightPower:TResourceRepositoryTexture;
      
      protected var FTexturesAwaken:TResourceRepositoryTexture;
      
      protected var FTexturesLostsacred:TResourceRepositoryTexture;
      
      public var TexturesWing:TResourceRepositoryTexture;
      
      public var TexturesBadge:TResourceRepositoryTexture;
      
      public var TexturesSpecialJade:TResourceRepositoryTexture;
      
      public var TexturesRune:TResourceRepositoryTexture;
      
      public var TexturesEmblem:TResourceRepositoryTexture;
      
      public var TexturesDafuben:TResourceRepositoryTexture;
      
      protected var FResourceBin:TResourceRepositoryBin;
      
      protected var FOnGarbageCollector:Function;
      
      public function TResourcesCore()
      {
         super();
         this.FRepositories = new Vector.<TResourceRepository>();
         this.FRepositorieTextures = new Vector.<TResourceRepositoryTexture>();
         this.ConstructRepositories();
      }
      
      protected function ConstructRepository(param1:String, param2:TResourceRepository) : void
      {
         param2.InstanceType = param1;
         this.FRepositories.push(param2);
      }
      
      protected function ConstructRepositoryBin(param1:String, param2:uint) : TResourceRepositoryBin
      {
         var _loc3_:TResourceRepositoryBin = null;
         _loc3_ = new TResourceRepositoryBin(param1,param2);
         this.ConstructRepository(param1,_loc3_);
         return _loc3_;
      }
      
      protected function ConstructRepositoryXML(param1:String, param2:uint) : TResourceRepositoryXml
      {
         var _loc3_:TResourceRepositoryXml = null;
         _loc3_ = new TResourceRepositoryXml(param1,param2);
         this.ConstructRepository(param1,_loc3_);
         return _loc3_;
      }
      
      protected function ConstructRepositorySWF(param1:String, param2:uint) : TResourceRepositorySwf
      {
         var _loc3_:TResourceRepositorySwf = null;
         _loc3_ = new TResourceRepositorySwf(param1,param2);
         this.ConstructRepository(param1,_loc3_);
         return _loc3_;
      }
      
      protected function ConstructRepositoryTexture(param1:String, param2:uint) : TResourceRepositoryTexture
      {
         var _loc3_:TResourceRepositoryTexture = null;
         _loc3_ = new TResourceRepositoryTexture(param1,param2);
         this.ConstructRepository(param1,_loc3_);
         this.FRepositorieTextures.push(_loc3_);
         return _loc3_;
      }
      
      protected function ConstructRepositories() : void
      {
         this.ConstructRepositories_Bin();
         this.ConstructRepositories_Swf();
         this.ConstructRepositories_Textures();
      }
      
      protected function ConstructRepositories_Bin() : void
      {
         if(SParametersCore.IsCombinServer)
         {
            this.FResourceBin = this.ConstructRepositoryBin("Resources/Bin/CombinServer/",1);
         }
         else
         {
            this.FResourceBin = this.ConstructRepositoryBin("Resources/Bin/NormalServer/",1);
         }
      }
      
      protected function ConstructRepositories_Swf() : void
      {
         this.FTexturesSwfVital = this.ConstructRepositorySWF("Resources/Swf/Vital/",10);
         this.FTexturesSwfCommon = this.ConstructRepositorySWF("Resources/Swf/Common/",11);
         this.FTexturesSwfCreateChar = this.ConstructRepositorySWF("Resources/Swf/CreateChar/",12);
         this.FTexturesSwfFont = this.ConstructRepositorySWF("Resources/Swf/Font/",13);
         this.FTexturesSwfChat = this.ConstructRepositorySWF("Resources/Swf/Chat/",14);
         this.FTexturesSwfLobby = this.ConstructRepositorySWF("Resources/Swf/Lobby/",15);
         this.FTexturesSwfPlot = this.ConstructRepositorySWF("Resources/Swf/Plot/",16);
         this.FTexturesSwfBattle = this.ConstructRepositorySWF("Resources/Swf/Battle/",17);
         this.FTexturesSwfSkill = this.ConstructRepositorySWF("Resources/Swf/Skill/",18);
      }
      
      protected function ConstructRepositories_Textures() : void
      {
         this.FTexturesVital = this.ConstructRepositoryTexture("Resources/Textures/Vital/",5);
         this.FTexturesPreview = this.ConstructRepositoryTexture("Resources/Textures/Preview/",19);
         this.FTexturesLobby = this.ConstructRepositoryTexture("Resources/Textures/Lobby/",20);
         this.FTexturesTryout = this.ConstructRepositoryTexture("Resources/Textures/Tryout/",21);
         this.FTexturesNightPower = this.ConstructRepositoryTexture("Resources/Textures/NightPower/",22);
         this.FTexturesFollowBloodBound = this.ConstructRepositoryTexture("Resources/Textures/FollowBloodBound/",23);
         this.FTexturesLargeIcon = this.ConstructRepositoryTexture("Resources/Textures/LargeIcon/",24);
         this.FTexturesInventory = this.ConstructRepositoryTexture("Resources/Textures/Inventory/",26);
         this.FTexturesBackgroundIcon = this.ConstructRepositoryTexture("Resources/Textures/BackgroundIcon/",28);
         this.FTexturesMiddlePic = this.ConstructRepositoryTexture("Resources/Textures/MiddlePicture/",32);
         this.FTexturesBuffIcon = this.ConstructRepositoryTexture("Resources/Textures/BuffIcon/",34);
         this.FTexturesHeadIcon = this.ConstructRepositoryTexture("Resources/Textures/HeadIcon/",36);
         this.FTexturesSkillIcon = this.ConstructRepositoryTexture("Resources/Textures/SkillPicture/",38);
         this.FTexturesDailytaskPicture = this.ConstructRepositoryTexture("Resources/Textures/DailytaskPicture/",40);
         this.FTexturesPet = this.ConstructRepositoryTexture("Resources/Textures/PetPicture/",42);
         this.FTexturesSmallIcon = this.ConstructRepositoryTexture("Resources/Textures/SmallIcon/",44);
         this.FTexturesModel = this.ConstructRepositoryTexture("Resources/Textures/Model/",46);
         this.FTexturesUserTitle = this.ConstructRepositoryTexture("Resources/Textures/UserTitle/",48);
         this.FTexturesFettersSmall = this.ConstructRepositoryTexture("Resources/Textures/FettersSmall/",49);
         this.FTexturesFettersBig = this.ConstructRepositoryTexture("Resources/Textures/FettersBig/",50);
         this.FTexturesAwaken = this.ConstructRepositoryTexture("Resources/Textures/Awaken/",51);
         this.FTexturesLostsacred = this.ConstructRepositoryTexture("Resources/Textures/Lostsacred/",52);
         this.TexturesWing = this.ConstructRepositoryTexture("Resources/Textures/Wings/",53);
         this.TexturesBadge = this.ConstructRepositoryTexture("Resources/Textures/Badge/",54);
         this.TexturesSpecialJade = this.ConstructRepositoryTexture("Resources/Textures/SpecialStone/",55);
         this.TexturesRune = this.ConstructRepositoryTexture("Resources/Textures/Rune/",56);
         this.TexturesEmblem = this.ConstructRepositoryTexture("Resources/Textures/Emblem/",57);
         this.TexturesDafuben = this.ConstructRepositoryTexture("Resources/Textures/Dafuben/",58);
      }
      
      public function get PrimaryCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TResourceRepository = null;
         _loc1_ = 0;
         _loc2_ = int(this.FRepositories.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FRepositories[_loc3_];
            _loc1_ += _loc4_.PrimaryCount;
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get Loading() : Boolean
      {
         return this.LoadingPrimary || this.LoadingSecondary;
      }
      
      public function get LoadingPrimary() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TResourceRepository = null;
         _loc1_ = int(this.FRepositories.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FRepositories[_loc2_];
            if(_loc3_.LoadingPrimary)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function get LoadingSecondary() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TResourceRepository = null;
         _loc1_ = int(this.FRepositories.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FRepositories[_loc2_];
            if(_loc3_.LoadingSecondary)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function get TexturesSwfVital() : TResourceRepositorySwf
      {
         return this.FTexturesSwfVital;
      }
      
      public function get TexturesSwfChat() : TResourceRepositorySwf
      {
         return this.FTexturesSwfChat;
      }
      
      public function get TexturesSwfLobby() : TResourceRepositorySwf
      {
         return this.FTexturesSwfLobby;
      }
      
      public function get TexturesSwfBattle() : TResourceRepositorySwf
      {
         return this.FTexturesSwfBattle;
      }
      
      public function get TexturesSwfCommon() : TResourceRepositorySwf
      {
         return this.FTexturesSwfCommon;
      }
      
      public function get TexturesSwfCreateChar() : TResourceRepositorySwf
      {
         return this.FTexturesSwfCreateChar;
      }
      
      public function get TexturesSwfFont() : TResourceRepositorySwf
      {
         return this.FTexturesSwfFont;
      }
      
      public function get TexturesSwfPlot() : TResourceRepositorySwf
      {
         return this.FTexturesSwfPlot;
      }
      
      public function get TexturesVital() : TResourceRepositoryTexture
      {
         return this.FTexturesVital;
      }
      
      public function get TexturesTryout() : TResourceRepositoryTexture
      {
         return this.FTexturesTryout;
      }
      
      public function get TexturesFollowBloodBound() : TResourceRepositoryTexture
      {
         return this.FTexturesFollowBloodBound;
      }
      
      public function get TexturesNightPower() : TResourceRepositoryTexture
      {
         return this.FTexturesNightPower;
      }
      
      public function get TexturesPreview() : TResourceRepositoryTexture
      {
         return this.FTexturesPreview;
      }
      
      public function get TexturesLobby() : TResourceRepositoryTexture
      {
         return this.FTexturesLobby;
      }
      
      public function get TexturesModel() : TResourceRepositoryTexture
      {
         return this.FTexturesModel;
      }
      
      public function get TexturesSwfSkill() : TResourceRepositorySwf
      {
         return this.FTexturesSwfSkill;
      }
      
      public function get TexturesSkillIcon() : TResourceRepositoryTexture
      {
         return this.FTexturesSkillIcon;
      }
      
      public function get TexturesDailytaskPicture() : TResourceRepositoryTexture
      {
         return this.FTexturesDailytaskPicture;
      }
      
      public function get TexturesLargeIcon() : TResourceRepositoryTexture
      {
         return this.FTexturesLargeIcon;
      }
      
      public function get TexturesSmallIcon() : TResourceRepositoryTexture
      {
         return this.FTexturesSmallIcon;
      }
      
      public function get TexturesHeadIcon() : TResourceRepositoryTexture
      {
         return this.FTexturesHeadIcon;
      }
      
      public function get TexturesMiddlePic() : TResourceRepositoryTexture
      {
         return this.FTexturesMiddlePic;
      }
      
      public function get TexturesPet() : TResourceRepositoryTexture
      {
         return this.FTexturesPet;
      }
      
      public function get TexturesBackgroundIcon() : TResourceRepositoryTexture
      {
         return this.FTexturesBackgroundIcon;
      }
      
      public function get TexturesInventory() : TResourceRepositoryTexture
      {
         return this.FTexturesInventory;
      }
      
      public function get TexturesBuffIcon() : TResourceRepositoryTexture
      {
         return this.FTexturesBuffIcon;
      }
      
      public function get ResourceBin() : TResourceRepositoryBin
      {
         return this.FResourceBin;
      }
      
      public function get TexturesUserTitle() : TResourceRepositoryTexture
      {
         return this.FTexturesUserTitle;
      }
      
      public function get TexturesFettersSmall() : TResourceRepositoryTexture
      {
         return this.FTexturesFettersSmall;
      }
      
      public function get TexturesFettersBig() : TResourceRepositoryTexture
      {
         return this.FTexturesFettersBig;
      }
      
      public function get TexturesAwaken() : TResourceRepositoryTexture
      {
         return this.FTexturesAwaken;
      }
      
      public function get TexturesLostsacred() : TResourceRepositoryTexture
      {
         return this.FTexturesLostsacred;
      }
      
      public function get OnGarbageCollector() : Function
      {
         return this.FOnGarbageCollector;
      }
      
      public function set OnGarbageCollector(param1:Function) : void
      {
         this.FOnGarbageCollector = param1;
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TResourceRepository = null;
         _loc1_ = int(this.FRepositories.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FRepositories[_loc2_];
            _loc3_.Process();
            SLoaderProgress.Update();
            _loc2_++;
         }
      }
      
      public function PerformAutoReleaseResources(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 == 0)
         {
            throw new Error(STRING_ERROR.TEXT_ERROR_ZERO);
         }
         _loc3_ = int(this.FRepositorieTextures.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FRepositorieTextures[_loc2_].PerformAutoReleaseResource(param1);
            _loc2_++;
         }
         if(this.FOnGarbageCollector != null)
         {
            this.FOnGarbageCollector();
         }
      }
   }
}

