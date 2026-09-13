package Processors.Game.Lobby.Pet
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TBasePet;
   import Logics.DatebaseVO.VO.TPetImage;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.Pet.TPet;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Pet.Component.TUIPetBox;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_PET;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowChangeBody extends TProcessorLobbyWindow
   {
      
      protected static const BoxNum:uint = 6;
      
      protected static const AllPet:uint = 32;
      
      protected static const TEMPNUMBER:uint = 18100000;
      
      protected static const RENDERINGSTATE_Normal:int = 1;
      
      protected static const RENDERINGSTATE_Selected:int = 2;
      
      protected static const RENDERINGSTATE_Disabled:int = 3;
      
      protected static const RENDERINGSTATE_Over:int = 4;
      
      protected var FIndex:uint;
      
      protected var FSoulIndex:uint;
      
      protected var FTempMC:MovieClip;
      
      protected var FPet:TPet;
      
      protected var FPetImage:TPetImage;
      
      protected var FBasePet:TBasePet;
      
      protected var FCharacter:TCharacter;
      
      protected var FMC_AllPetBody:Sprite;
      
      protected var FPetBoxs:Vector.<TUIPetBox>;
      
      protected var FTF_Name:TextField;
      
      protected var FImageLockLevel:Vector.<uint>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTF_Page:TextField;
      
      protected var FBT_ChangeBody:MovieClip;
      
      protected var FMC_ChangeBody:Sprite;
      
      protected var FHint:THint;
      
      protected var FImageBin:TBins;
      
      protected var FRoleModel:TBins;
      
      protected var FBasePetBin:TBins;
      
      protected var FHightLight:int;
      
      protected var FUnLuckPetNum:int;
      
      protected var FPageIndex:int;
      
      protected var FSelectPageIndex:int;
      
      protected var FFirstBoo:Boolean;
      
      protected var FInitialization:Boolean;
      
      protected var FInitializationSlots:Boolean;
      
      protected var FPets:Vector.<TPet>;
      
      protected var FNewPets:Vector.<TPet>;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FNextPanle:Function;
      
      public function TProcessorWindowChangeBody(param1:TUIComponent)
      {
         super(param1);
         this.FPetBoxs = new Vector.<TUIPetBox>(BoxNum);
         this.FImageLockLevel = new Vector.<uint>();
         this.FUIPage = new TUIPage(this);
         this.FHightLight = -1;
         this.FPet = SLogicsCore.Character.Pet;
         this.FCharacter = SLogicsCore.Character;
         this.FHint = new THint();
         this.FPets = new Vector.<TPet>();
         this.FNewPets = new Vector.<TPet>();
         this.FInitializationSlots = false;
         this.FInitialization = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PET.RESOURCESID_PET);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Sprite = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TUIPetBox = null;
         var _loc7_:TPet = null;
         var _loc8_:TRoleModel = null;
         var _loc9_:uint = 0;
         this.FMC_ChangeBody = TUtilityReflection.CreateDisplayObjectInstance(CONST_PET.RESOURCE_Link_MC_ChangeBody) as Sprite;
         this.addChild(this.FMC_ChangeBody);
         this.FMC_AllPetBody = this.FMC_ChangeBody[CONST_PET.RESOURCE_Link_MC_AllPetBody];
         _loc1_ = 0;
         while(_loc1_ < BoxNum)
         {
            _loc3_ = this.FMC_AllPetBody[CONST_PET.RESOURCE_Link_MC_PetBoxs + _loc1_] as MovieClip;
            _loc6_ = new TUIPetBox(this);
            _loc6_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc6_.Perform_UIDispatch(_loc3_);
            _loc6_.OnClick = this.BoxOnClick;
            _loc6_.OnDoubleClick = this.BoxOnDoubleClick;
            _loc6_.Over = this.BoxOnOver;
            _loc6_.Out = this.BoxOnOut;
            this.FPetBoxs[_loc1_] = _loc6_;
            _loc1_++;
         }
         _loc5_ = this.FMC_AllPetBody[CONST_PET.RESOURCE_Link_MC_PagePre];
         this.FUIPage.ButtonPrevious.Substrate = _loc5_;
         _loc5_ = this.FMC_AllPetBody[CONST_PET.RESOURCE_Link_MC_PageNext];
         this.FUIPage.ButtonNext.Substrate = _loc5_;
         this.FUIPage.PageSize = BoxNum;
         this.FTF_Page = this.FMC_AllPetBody[CONST_PET.RESOURCE_Link_TF_Page];
         this.FTF_Page.mouseEnabled = false;
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FTF_Page.text = "0/0";
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FBT_ChangeBody = this.FMC_AllPetBody[CONST_PET.RESOURCE_Link_BT_ChangeBody];
         TGameUtil.setButtonMode(this.FBT_ChangeBody,true);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(this.FInitializationSlots)
         {
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               this.FPetBoxs[_loc1_].UpDateSlot();
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBT_ChangeBody.addEventListener(MouseEvent.CLICK,this.ChangeBody);
         super.ResourcesPerform_UILocations();
      }
      
      protected function BoxOnClick(param1:TUIPetBox) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TBasePet = null;
         var _loc4_:uint = 0;
         var _loc5_:TPet = null;
         _loc5_ = param1.MyContext as TPet;
         _loc2_ = this.FPets.indexOf(_loc5_);
         this.FSelectPageIndex = uint(_loc2_ / BoxNum);
         _loc2_ = 0;
         while(_loc2_ < BoxNum)
         {
            if(this.FPetBoxs[_loc2_].FMC.currentFrame == RENDERINGSTATE_Selected)
            {
               this.FPetBoxs[_loc2_].FMC.gotoAndStop(RENDERINGSTATE_Normal);
               this.FPetBoxs[_loc2_].FBClick = false;
            }
            _loc2_++;
         }
         this.FHightLight = this.FPetBoxs.indexOf(param1);
      }
      
      protected function BoxOnDoubleClick(param1:TUIPetBox) : void
      {
         var _loc2_:TPet = null;
         _loc2_ = param1.MyContext as TPet;
         var _loc3_:Boolean = this.FPet.IsUnlock(_loc2_.PetID);
         if(!_loc3_ && _loc2_.IsPetNewType)
         {
            this.FUIWindowConfirmation.Text = _loc2_.LockDesc;
            this.FUIWindowConfirmation.Context = _loc2_.PetID;
            this.FUIWindowConfirmation.Visible = true;
         }
      }
      
      protected function BoxOnOver(param1:TUIPetBox, param2:String, param3:uint) : void
      {
         if(param3 == 0)
         {
            this.FHint.Caption = this.GetInformation(param2);
         }
         else
         {
            this.FHint.Caption = param2;
         }
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function BoxOnOut(param1:TUIPetBox) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TPet = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TPet;
         _loc6_ = SResourcesCore.TexturesPet;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.MiddleIcon);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(1);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.MiddleIcon,CONST_MODULES.MODULE_Pet);
         }
      }
      
      protected function GetInformation(param1:String) : String
      {
         var _loc2_:Array = null;
         _loc2_ = param1.split("\\n");
         return _loc2_[0] + "\n\n" + _loc2_[1] + "\n" + _loc2_[2];
      }
      
      protected function ChangeBody(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ChangePetRequest);
         _loc4_ = this.FPageIndex * BoxNum + this.FHightLight;
         var _loc5_:TPet = this.FPets[_loc4_];
         if(_loc5_.IsPetNewType && !this.FPet.IsUnlock(_loc5_.PetID) || !_loc5_.IsPetNewType && _loc4_ >= this.FPet.Images.length)
         {
            return;
         }
         if(_loc5_.IsPetNewType)
         {
            this.FPet.ImageID = _loc5_.PetBigImageID;
         }
         else
         {
            this.FPet.ImageID = this.FPet.Images[_loc4_];
         }
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FPet.ImageID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         TGameUtil.LockOrUnlockButton(param1.target as MovieClip,false);
      }
      
      protected function OnBTActivate() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Pet_Item_Unlock_Req);
         _loc3_ = this.FUIWindowConfirmation.Context as int;
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function SlotUpdate() : void
      {
         var _loc1_:TBasePet = null;
         _loc1_ = this.FBasePetBin.GetDatebaseByIdentifier(this.FPet.PetID) as TBasePet;
         this.FUnLuckPetNum = _loc1_.ImagesVect.length;
      }
      
      protected function UpdateUIPage() : void
      {
         this.FUIPage.TotalQuantity = this.FPets.length;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         var _loc3_:uint = 0;
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         _loc3_ = 0;
         while(_loc3_ < BoxNum)
         {
            if(this.FPetBoxs[_loc3_].UnLuckBoo)
            {
               this.FPetBoxs[_loc3_].FMC.gotoAndStop(RENDERINGSTATE_Normal);
            }
            _loc3_++;
         }
         this.UpdateUIPetBox(this.FPetBoxs,this.FPets);
      }
      
      protected function UpdateUIPetBox(param1:Vector.<TUIPetBox>, param2:Vector.<TPet>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TUIPetBox = null;
         var _loc10_:Sprite = null;
         var _loc11_:TPet = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:int = 0;
         var _loc15_:Boolean = false;
         _loc13_ = this.FPet.Images.indexOf(this.FPet.ImageID);
         _loc7_ = this.FPageIndex;
         _loc4_ = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc9_ = param1[_loc3_];
            _loc9_.MyContext = null;
            _loc9_.FMC.visible = false;
            _loc9_.FlevelEnough = false;
            _loc9_.FBClick = false;
            _loc3_++;
         }
         _loc4_ = int(param2.length);
         _loc5_ = param2.length - this.FNewPets.length;
         if(_loc4_ <= 0)
         {
            return;
         }
         _loc6_ = _loc7_ * param1.length;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ + _loc6_ >= _loc4_)
            {
               break;
            }
            _loc9_ = param1[_loc3_];
            _loc11_ = param2[_loc3_ + _loc6_];
            _loc9_.MyContext = _loc11_;
            if(_loc3_ + _loc6_ < _loc5_)
            {
               if(_loc3_ + _loc6_ > this.FUnLuckPetNum - 1)
               {
                  _loc9_.FMC.gotoAndStop(RENDERINGSTATE_Disabled);
                  _loc9_.SetBlack();
                  _loc9_.FBClick = false;
                  _loc9_.UnLuckBoo = false;
                  if(this.FCharacter.MainHero.Level >= _loc11_.LevelLimit)
                  {
                     _loc9_.MCImageLockDesc = false;
                     _loc9_.FlevelEnough = true;
                     _loc9_.FMC.gotoAndStop(RENDERINGSTATE_Normal);
                  }
                  else
                  {
                     _loc9_.MCImageLockDesc = true;
                  }
               }
               else
               {
                  _loc9_.FMC.gotoAndStop(RENDERINGSTATE_Normal);
                  _loc9_.FBClick = false;
                  if(this.FPageIndex == this.FSelectPageIndex)
                  {
                     param1[this.FHightLight].FMC.gotoAndStop(RENDERINGSTATE_Selected);
                     param1[this.FHightLight].FBClick = true;
                  }
                  _loc9_.SetNormal();
                  _loc9_.FlevelEnough = false;
                  _loc9_.UnLuckBoo = true;
                  _loc9_.MCImageLockDesc = false;
               }
            }
            else
            {
               _loc14_ = this.FPet.UnlockPetIds.indexOf(_loc11_.PetID);
               _loc15_ = _loc14_ > -1;
               if(_loc15_)
               {
                  _loc9_.FMC.gotoAndStop(RENDERINGSTATE_Normal);
                  _loc9_.FBClick = false;
                  if(this.FPageIndex == this.FSelectPageIndex)
                  {
                     param1[this.FHightLight].FMC.gotoAndStop(RENDERINGSTATE_Selected);
                     param1[this.FHightLight].FBClick = true;
                  }
                  _loc9_.SetNormal();
                  _loc9_.FlevelEnough = false;
                  _loc9_.UnLuckBoo = true;
                  _loc9_.MCImageLockDesc = false;
               }
               else
               {
                  _loc9_.FMC.gotoAndStop(RENDERINGSTATE_Disabled);
                  _loc9_.SetBlack();
                  _loc9_.FBClick = false;
                  _loc9_.UnLuckBoo = false;
                  _loc9_.MCImageLockDesc = false;
                  _loc9_.FlevelEnough = false;
               }
            }
            _loc9_.FMC.visible = true;
            _loc3_++;
         }
         this.FInitializationSlots = true;
      }
      
      protected function UpdatePets() : void
      {
         var _loc1_:TPet = null;
         var _loc2_:TPetImage = null;
         var _loc3_:TBasePet = null;
         var _loc4_:uint = 0;
         _loc4_ = 0;
         while(_loc4_ < this.FImageBin.Count)
         {
            _loc1_ = new TPet();
            _loc2_ = this.FImageBin.GetDatebaseByIndex(_loc4_) as TPetImage;
            _loc1_.PetID = _loc2_.Identifier;
            _loc1_.Name = _loc2_.Name;
            _loc1_.LevelLimit = _loc2_.Level;
            _loc1_.Desc = _loc2_.Desc;
            _loc1_.LockDesc = _loc2_.LockDesc;
            _loc1_.MiddleIcon = _loc2_.HeadPic;
            _loc1_.PetBigImageID = _loc2_.HeadPic;
            this.FPets.push(_loc1_);
            _loc3_ = this.FBasePetBin.GetDatebaseByIdentifier(_loc2_.Identifier) as TBasePet;
            if(_loc1_.IsPetNewType)
            {
               this.FNewPets.push(_loc1_);
            }
            _loc4_++;
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         this.OnBTActivate();
      }
      
      protected function getPetImageIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:TPet = null;
         _loc2_ = 0;
         while(_loc2_ < this.FPets.length)
         {
            _loc3_ = this.FPets[_loc2_];
            if(_loc3_.MiddleIcon == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get ImageBin() : TBins
      {
         return this.FImageBin;
      }
      
      public function set ImageBin(param1:TBins) : void
      {
         this.FImageBin = param1;
      }
      
      public function get BasePetBin() : TBins
      {
         return this.FBasePetBin;
      }
      
      public function set BasePetBin(param1:TBins) : void
      {
         this.FBasePetBin = param1;
      }
      
      public function get RoleModel() : TBins
      {
         return this.FRoleModel;
      }
      
      public function set RoleModel(param1:TBins) : void
      {
         this.FRoleModel = param1;
      }
      
      public function get NextPanle() : Function
      {
         return this.FNextPanle;
      }
      
      public function set NextPanle(param1:Function) : void
      {
         this.FNextPanle = param1;
      }
      
      public function UpdateBox() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc2_ = uint(this.FPet.ImageID);
         this.SlotUpdate();
         if(!this.FInitialization)
         {
            this.UpdatePets();
            this.FInitialization = true;
         }
         _loc1_ = uint(this.getPetImageIndex(_loc2_));
         this.FHightLight = _loc1_;
         this.FPageIndex = 0;
         if(this.FHightLight >= BoxNum)
         {
            this.FPageIndex = uint(this.FHightLight / BoxNum);
            this.FHightLight -= this.FPageIndex * BoxNum;
         }
         this.FSelectPageIndex = this.FPageIndex;
         this.UpdateUIPage();
         this.UpdateUIPetBox(this.FPetBoxs,this.FPets);
      }
      
      public function UpdateUnLuck() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FPet.Images[this.FPet.Images.length - 1];
         this.SlotUpdate();
         _loc1_ = this.FPet.Images.indexOf(_loc2_);
         this.FHightLight = _loc1_;
         this.FPageIndex = 0;
         if(this.FHightLight >= BoxNum)
         {
            this.FPageIndex = uint(this.FHightLight / BoxNum);
            this.FHightLight -= this.FPageIndex * BoxNum;
         }
         this.FSelectPageIndex = this.FPageIndex;
         this.UpdateUIPage();
         this.UpdateUIPetBox(this.FPetBoxs,this.FPets);
      }
      
      public function SetChangBtNormal() : void
      {
         TGameUtil.LockOrUnlockButton(this.FBT_ChangeBody,true);
      }
   }
}

