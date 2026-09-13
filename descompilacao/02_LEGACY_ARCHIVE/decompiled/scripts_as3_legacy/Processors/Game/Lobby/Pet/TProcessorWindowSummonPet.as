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
   import Processors.Game.Lobby.Pet.Component.TUIPetBigIcon;
   import Processors.Game.Lobby.Pet.Component.TUIPetBox;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_PET;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowSummonPet extends TProcessorLobbyWindow
   {
      
      protected static const BoxNum:uint = 1;
      
      protected static const AllPet:uint = 2;
      
      protected static const TEMPNUMBER:uint = 18100000;
      
      protected static const RENDERINGSTATE_Normal:int = 1;
      
      protected static const RENDERINGSTATE_Selected:int = 2;
      
      protected static const RENDERINGSTATE_Disabled:int = 3;
      
      protected static const RENDERINGSTATE_Over:int = 4;
      
      protected var FIndex:uint;
      
      protected var FSoulIndex:uint;
      
      protected var FTempMC:MovieClip;
      
      protected var FUIBigIcon:TUIPetBigIcon;
      
      protected var FPetBoxs:Vector.<TUIPetBox>;
      
      protected var FMC_BigIcon:Sprite;
      
      protected var FMCLock:MovieClip;
      
      protected var FPet:TPet;
      
      protected var FBasePet:TBasePet;
      
      protected var FCharacter:TCharacter;
      
      protected var FMC_AllPetBody:Sprite;
      
      protected var FTF_Name:TextField;
      
      protected var FImageLockLevel:Vector.<uint>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTF_Page:TextField;
      
      protected var FBT_ChangeBody:MovieClip;
      
      protected var FBT_Activate:MovieClip;
      
      protected var FMC_ChangeBody:Sprite;
      
      protected var FHint:THint;
      
      protected var FImageBin:TBins;
      
      protected var FRoleModel:TBins;
      
      protected var FBasePetBin:TBins;
      
      protected var FRoleModle:TBins;
      
      protected var FHightLight:int;
      
      protected var FUnLuckPetNum:int;
      
      protected var FPageIndex:int = -1;
      
      protected var FSelectPageIndex:int;
      
      protected var FFirstBoo:Boolean;
      
      protected var FInitialization:Boolean;
      
      protected var FPets:Vector.<TPet>;
      
      protected var FCurPet:TPet;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FNextPanle:Function;
      
      public function TProcessorWindowSummonPet(param1:TUIComponent)
      {
         super(param1);
         this.FImageLockLevel = new Vector.<uint>();
         this.FUIPage = new TUIPage(this);
         this.FHightLight = -1;
         this.FPet = SLogicsCore.Character.Pet;
         this.FCharacter = SLogicsCore.Character;
         this.FHint = new THint();
         this.FPets = new Vector.<TPet>();
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
         this.FMC_ChangeBody = TUtilityReflection.CreateDisplayObjectInstance(CONST_PET.RESOURCE_Link_MC_SummonPet) as Sprite;
         this.addChild(this.FMC_ChangeBody);
         this.FMC_AllPetBody = this.FMC_ChangeBody[CONST_PET.RESOURCE_Link_MC_AllPetBody];
         this.FMC_BigIcon = this.FMC_AllPetBody[CONST_PET.RESOURCE_Link_MC_BigIcon];
         this.FMC_BigIcon.mouseEnabled = false;
         this.FUIBigIcon = new TUIPetBigIcon(this);
         this.FUIBigIcon.mouseEnabled = false;
         this.FMC_BigIcon.addChild(this.FUIBigIcon);
         this.FUIBigIcon.OnQuerySequenceContext = this.PetIconOnQuerySequenceContext;
         this.FUIBigIcon.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
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
         this.FTF_Name = this.FMC_AllPetBody[CONST_PET.RESOURCE_Link_TF_Name];
         this.FMCLock = this.FMC_AllPetBody[CONST_PET.RESOURCE_Link_MC_Lock];
         this.FBT_ChangeBody = this.FMC_AllPetBody[CONST_PET.RESOURCE_Link_BT_ChangeBody];
         TGameUtil.setButtonMode(this.FBT_ChangeBody,true);
         this.FBT_Activate = this.FMC_AllPetBody[CONST_PET.RESOURCE_Link_BT_Activate];
         TGameUtil.setButtonMode(this.FBT_Activate,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(this.FUIBigIcon != null)
         {
            this.FUIBigIcon.Update();
         }
         super.LogicsPerform();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBT_ChangeBody.addEventListener(MouseEvent.CLICK,this.ChangeBody);
         this.FBT_Activate.addEventListener(MouseEvent.CLICK,this.OnBTActivate);
         super.ResourcesPerform_UILocations();
      }
      
      protected function BoxOnClick(param1:TUIPetBox) : void
      {
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
      
      protected function GetName(param1:uint) : void
      {
         var _loc2_:TPetImage = null;
         var _loc3_:TRoleModel = null;
         _loc2_ = this.FImageBin.GetDatebaseByIdentifier(param1) as TPetImage;
         this.FPet.Name = _loc2_.Name;
         _loc3_ = this.FRoleModle.GetDatebaseByIdentifier(param1) as TRoleModel;
         this.FPet.SmallIcon = _loc3_.RoleHead;
         this.FPet.PetBigImageID = _loc3_.RoleStyle;
         this.FPet.PetModelID = _loc2_.Identifier;
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
         if(this.FCurPet == null)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ChangePetRequest);
         this.FPet.PetImageID = this.FCurPet.PetImageID;
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FPet.PetImageID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         TGameUtil.LockOrUnlockButton(param1.target as MovieClip,false);
      }
      
      protected function OnBTActivate(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FCurPet == null)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Pet_Item_Unlock_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FCurPet.PetID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function SlotUpdate() : void
      {
         var _loc1_:TBasePet = null;
         _loc1_ = this.FBasePetBin.GetDatebaseByIdentifier(this.FPet.PetID) as TBasePet;
         this.FUnLuckPetNum = _loc1_.ImagesVect.length;
      }
      
      protected function UpdateUIPage() : void
      {
         this.FUIPage.TotalQuantity = AllPet;
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
         this.FCurPet = this.FPets[param2];
         this.UpdateUIPetBox(this.FCurPet);
      }
      
      protected function UpdateUIPetBox(param1:TPet) : void
      {
         this.FUIBigIcon.Context = param1 as TPet;
         this.FUIBigIcon.Frame = 2;
         this.FUIBigIcon.Update();
         this.UpdateAttributeInfo(param1);
         this.UpdateUnLuck();
         this.FTF_Name.text = param1.Name;
      }
      
      protected function PetIconOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint) : void
      {
         var _loc5_:TPet = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TPet;
         _loc6_ = SResourcesCore.TexturesPet;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.PetBigImageID);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.PetBigImageID,CONST_MODULES.MODULE_Pet);
         }
      }
      
      protected function UpdatePets() : void
      {
         var _loc1_:TPet = null;
         var _loc2_:TPetImage = null;
         var _loc3_:TBasePet = null;
         var _loc4_:uint = 0;
         _loc4_ = 0;
         while(_loc4_ < this.FBasePetBin.Count)
         {
            _loc1_ = new TPet();
            _loc3_ = this.FBasePetBin.GetDatebaseByIndex(_loc4_) as TBasePet;
            if(Boolean(_loc3_) && _loc3_.ItemArr.length > 0)
            {
               _loc2_ = this.FImageBin.GetDatebaseByIdentifier(_loc3_.Identifier) as TPetImage;
               _loc1_.PetID = _loc2_.Identifier;
               _loc1_.Name = _loc2_.Name;
               _loc1_.LevelLimit = _loc2_.Level;
               _loc1_.Desc = _loc2_.Desc;
               _loc1_.LockDesc = _loc2_.LockDesc;
               _loc1_.MiddleIcon = _loc2_.HeadPic;
               _loc1_.PetBigImageID = _loc2_.HeadPic;
               _loc1_.PetImageID = _loc2_.HeadPic;
               this.FPets.push(_loc1_);
            }
            _loc4_++;
         }
      }
      
      protected function UpdateAttributeInfo(param1:TPet) : void
      {
         var _loc2_:TBasePet = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         if(param1)
         {
            _loc2_ = this.FBasePetBin.GetDatebaseByIdentifier(param1.PetID) as TBasePet;
            _loc3_ = "";
            for each(_loc4_ in _loc2_.SpecialArr)
            {
               _loc3_ += this.AttributeFormat(_loc4_[0],_loc4_[1]) + "\n";
            }
            this.FMC_AllPetBody["TF_Attr"].text = _loc3_;
         }
      }
      
      protected function AttributeFormat(param1:int, param2:Number) : String
      {
         var _loc3_:int = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(param1);
         var _loc4_:String = "";
         if(_loc3_ != -1)
         {
            _loc4_ = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc3_];
         }
         if(param2 != 0)
         {
            if(param2 > 1)
            {
               return _loc4_ + " +" + param2;
            }
            return _loc4_ + " +" + (param2 * 100).toFixed(0) + "%";
         }
         return _loc4_;
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
      
      public function get RoleModle() : TBins
      {
         return this.FRoleModle;
      }
      
      public function set RoleModle(param1:TBins) : void
      {
         this.FRoleModle = param1;
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
         if(!this.FInitialization)
         {
            this.UpdatePets();
            this.PageOnChange(null,0);
            this.FInitialization = true;
         }
         this.UpdateUIPage();
      }
      
      public function UpdateUnLuck() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         if(this.FCurPet)
         {
            _loc2_ = this.FPet.UnlockPetIds.indexOf(this.FCurPet.PetID);
            _loc1_ = _loc2_ > -1;
            this.FUIBigIcon.filters = _loc1_ == true ? [] : [TGameUtil.GaryColorFilters];
            this.FMCLock.visible = _loc1_ == true ? false : true;
         }
      }
      
      public function OnChangeBody() : void
      {
         this.GetName(this.FPet.ImageID);
      }
      
      public function SetChangBtNormal() : void
      {
         TGameUtil.LockOrUnlockButton(this.FBT_ChangeBody,true);
      }
   }
}

