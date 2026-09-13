package Processors.Game.Lobby.Pet
{
   import Foundation.Common.TAlignment;
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TBasePet;
   import Logics.DatebaseVO.VO.TPetMonster;
   import Logics.DatebaseVO.VO.TPetMonsterExp;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Pet.TPet;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Pet.Component.TUIEnergyBar;
   import Processors.Game.Lobby.Pet.Component.TUITrainSoulBox;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Editors.TUIWindowEditor;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_FONTLIBRARY;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_PET;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_PET;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class TProcessorWindowTrainPetSoul extends TProcessorLobbyWindow
   {
      
      protected static const SoulNum:uint = 6;
      
      protected static const STRING_Capacity:String = CONST_COMMON.STRING_Capacity;
      
      protected static const ConsumeGold:uint = 10;
      
      protected static const FRefiningSoul:uint = CONST_INVENTORY.CATEGORYSECOND_RefiningSoul;
      
      public static const FORMAT_ExpandPrompt:String = STRING_PET.STRING_ExpandPrompt;
      
      protected static const TEMPNUMBER:uint = 18300000;
      
      protected static const BATCH_LIMIT:uint = 3;
      
      protected static const RENDERINGSTATE_DISABLED:int = 4;
      
      protected static const RENDERINGSTATE_NORMAL:int = 1;
      
      protected static const MAX_NUMBER:int = 60000;
      
      protected static const FPsychicReel:uint = CONST_INVENTORY.CATEGORYSECOND_RefiningSoul;
      
      protected var FSoulIndex:uint;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FUITrainSoulBox:TUITrainSoulBox;
      
      protected var FModalLayer:Sprite;
      
      protected var FTF_TotalLevelInner:TextField;
      
      protected var FMC_TotalLevelInner:Sprite;
      
      protected var FMC_TotalLevel:MovieClip;
      
      protected var FTF_RemainNum:TextField;
      
      protected var FMC_TrainSoulStage:MovieClip;
      
      protected var FBT_TrainPetSoul:MovieClip;
      
      protected var FBT_BatchTrainSoul:MovieClip;
      
      protected var FMC_TrainSoul:Sprite;
      
      protected var FPetMonsterExp:TPetMonsterExp;
      
      protected var FPetMonster:TPetMonster;
      
      protected var FPetMonsterExpBin:TBins;
      
      protected var FPetMonsterBin:TBins;
      
      protected var FMC_EnergyBars:Vector.<TUIEnergyBar>;
      
      protected var FBTs:Vector.<MovieClip>;
      
      protected var FUIWindowEditor:TUIWindowEditor;
      
      protected var FMaxTimes:int;
      
      protected var FHint:THint;
      
      protected var FPet:TPet;
      
      protected var FCharacter:TCharacter;
      
      protected var FSetOpenLevel:int = 0;
      
      protected var FInitialization:Boolean;
      
      protected var FOnClickTrainSoul:Function;
      
      protected var FLighBoo:Boolean;
      
      protected var FBarBoo:Boolean;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnShowBox:Function;
      
      public function TProcessorWindowTrainPetSoul(param1:TUIComponent)
      {
         super(param1);
         this.FMC_EnergyBars = new Vector.<TUIEnergyBar>(SoulNum);
         this.FBTs = new Vector.<MovieClip>();
         this.FPet = SLogicsCore.Character.Pet;
         this.FCharacter = SLogicsCore.Character;
         this.FHint = new THint();
         this.FInitialization = false;
      }
      
      public function get SetOpenLevel() : uint
      {
         return this.FSetOpenLevel;
      }
      
      public function set SetOpenLevel(param1:uint) : void
      {
         this.FSetOpenLevel = param1;
         var _loc2_:TBasePet = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BasePet,this.FSetOpenLevel) as TBasePet;
         if(_loc2_ != null)
         {
            this.FSetOpenLevel = _loc2_.ReviceCount;
         }
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
         var _loc3_:TUIEnergyBar = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Rectangle = null;
         var _loc6_:BitmapData = null;
         var _loc7_:MovieClip = null;
         var _loc8_:TPainterTextEffect = null;
         var _loc9_:TBounds = null;
         var _loc10_:Bitmap = null;
         this.FMC_TrainSoul = TUtilityReflection.CreateDisplayObjectInstance(CONST_PET.RESOURCE_Link_MC_TrainSoul) as Sprite;
         this.addChild(this.FMC_TrainSoul);
         this.FMC_TrainSoulStage = this.FMC_TrainSoul[CONST_PET.RESOURCE_Link_MC_TrainSoulStage];
         _loc1_ = 0;
         while(_loc1_ < SoulNum)
         {
            _loc4_ = this.FMC_TrainSoulStage[CONST_PET.RESOURCE_Link_MC_EnergyBars + _loc1_];
            _loc3_ = new TUIEnergyBar(this);
            _loc3_.Perform_UIDispatch(_loc4_);
            this.FMC_EnergyBars[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FBT_TrainPetSoul = this.FMC_TrainSoulStage[CONST_PET.RESOURCE_Link_BT_TrainPetSoul];
         TGameUtil.setButtonMode(this.FBT_TrainPetSoul,true);
         this.FBT_BatchTrainSoul = this.FMC_TrainSoulStage[CONST_PET.RESOURCE_Link_BT_BatchTrainSoul];
         TGameUtil.setButtonMode(this.FBT_BatchTrainSoul,true);
         this.FBTs.push(this.FBT_TrainPetSoul);
         this.FBTs.push(this.FBT_BatchTrainSoul);
         this.FMC_TotalLevel = this.FMC_TrainSoulStage[CONST_PET.RESOURCE_Link_MC_TotalLevel] as MovieClip;
         this.FMC_TotalLevelInner = this.FMC_TotalLevel[CONST_PET.RESOURCE_Link_MC_TotalLevelInner];
         this.FTF_TotalLevelInner = this.FMC_TotalLevelInner[CONST_PET.RESOURCE_Link_TF_TotalLevelInner];
         this.FTF_RemainNum = this.FMC_TrainSoulStage[CONST_PET.RESOURCE_Link_TF_RemainNum];
         this.FUITrainSoulBox = new TUITrainSoulBox(this);
         this.FUITrainSoulBox.visible = false;
         this.FUITrainSoulBox.OnSetMax = this.WindowEditorOnMax;
         this.FUITrainSoulBox.OnClickOk = this.WindowEditorOnOK;
         this.FUITrainSoulBox.Init();
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FUIWindowInformation.SetCheckBox(true);
         this.FModalLayer = new Sprite();
         this.FModalLayer.graphics.beginFill(0,0.3);
         this.FModalLayer.graphics.drawRect(0,0,632,482);
         this.FModalLayer.graphics.endFill();
         _loc8_ = new TPainterTextEffect(this);
         _loc8_.Font.Name = CONST_FONTLIBRARY.FONT_NAME_Naruto_UI_00;
         _loc8_.Font.Size = 50;
         _loc8_.Font.Color = 16777215;
         _loc8_.FontEffect.AntiAliased = true;
         _loc8_.FontEffect.Outlined = true;
         _loc8_.FontEffect.OutlineSize = 5;
         _loc8_.FontEffect.ShadowColor = 1245184;
         _loc8_.mouseEnabled = false;
         _loc8_.Text = STRING_PET.STRING_SoulTip;
         _loc9_ = new TBounds();
         _loc9_.X = (this.FModalLayer.width - _loc8_.width) / 2;
         _loc9_.Y = (387 - _loc8_.height) / 2;
         _loc9_.Width = _loc8_.width;
         _loc9_.Height = _loc8_.height;
         _loc8_.RenderBounds(_loc9_,TAlignment.HORIZONTAL_Center);
         this.FModalLayer.addChild(_loc8_);
         addChild(this.FModalLayer);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:uint = 0;
         this.FBT_TrainPetSoul.addEventListener(MouseEvent.CLICK,this.TrainPetSoulOnTrainSoul);
         this.FBT_TrainPetSoul.addEventListener(MouseEvent.MOUSE_MOVE,this.TrainPetSoulOverTrainSoul);
         this.FBT_TrainPetSoul.addEventListener(MouseEvent.MOUSE_OUT,this.TrainPetSoulOnOut);
         this.FBT_BatchTrainSoul.addEventListener(MouseEvent.CLICK,this.TrainPetSoulOnTrainSoul);
         this.FInitialization = true;
         super.ResourcesPerform_UILocations();
      }
      
      public function SetBtDisable(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc3_ = this.FBTs.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            TGameUtil.LockOrUnlockButton(this.FBTs[_loc2_],param1);
            _loc2_++;
         }
         if(param1)
         {
            this.BatchBT();
         }
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         if(this.FOnClickTrainSoul != null)
         {
            this.FOnClickTrainSoul(this.FPet.TrainTimes);
            this.SetBtDisable(false);
         }
      }
      
      protected function GetItemCountByType(param1:TInventories, param2:uint) : uint
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TInventory = null;
         _loc5_ = uint(param1.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc6_ = param1.GetInventoryByIndex(_loc3_);
            if(_loc6_.CategorySecond == param2)
            {
               _loc4_ += _loc6_.Quantity;
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      protected function TrainPetSoulOnTrainSoul(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         if(SLogicsCore.Character.MaxTempValue)
         {
            return;
         }
         _loc2_ = this.FCharacter.CreditGold;
         _loc3_ = this.FCharacter.CreditGiftCertificate;
         _loc5_ = this.FCharacter.Appliances;
         _loc4_ = this.GetItemCountByType(_loc5_,FRefiningSoul);
         switch(param1.target)
         {
            case this.FBT_TrainPetSoul:
               if(_loc4_ * 10 + _loc2_ + _loc3_ >= ConsumeGold)
               {
                  this.FPet.TrainTimes = 1;
                  if(!this.FUIWindowInformation.IsSelected)
                  {
                     this.FUIWindowInformation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Pet_RefiningSoul).DescribeString,10,STRING_PET.STRING_SoulTrain);
                     this.FUIWindowInformation.Visible = true;
                     return;
                  }
                  if(this.FOnClickTrainSoul != null)
                  {
                     this.FOnClickTrainSoul(this.FPet.TrainTimes);
                     this.SetBtDisable(false);
                  }
               }
               else
               {
                  EffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
               }
               break;
            case this.FBT_BatchTrainSoul:
               _loc6_ = _loc4_ * 10 + _loc3_ + _loc2_;
               this.FMaxTimes = Math.floor(_loc6_ / ConsumeGold);
               if(this.FMaxTimes > MAX_NUMBER)
               {
                  this.FMaxTimes = MAX_NUMBER;
               }
               this.FUITrainSoulBox.CurCount = _loc4_;
               this.FUITrainSoulBox.Value = Math.min(_loc4_,50);
               this.FUITrainSoulBox.Min = 1;
               this.FUITrainSoulBox.Max = this.FMaxTimes;
               this.FUITrainSoulBox.visible = true;
         }
      }
      
      protected function TrainPetSoulOverTrainSoul(param1:MouseEvent) : void
      {
         this.FHint.Caption = STRING_PET.STRING_TrainSoulOnce;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function TrainPetSoulOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function WindowEditorOnOK(param1:Object) : void
      {
         if(this.FUITrainSoulBox.Value == 0)
         {
            EffectGenerateText(STRING_COMMON.NOTENOUGH_Niemi);
            return;
         }
         if(this.FOnClickTrainSoul != null)
         {
            this.FPet.TrainTimes = this.FUITrainSoulBox.Value;
            this.FOnClickTrainSoul(this.FUITrainSoulBox.Value);
            this.SetBtDisable(false);
         }
      }
      
      protected function WindowEditorOnMax(param1:Object) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = this.FUITrainSoulBox.CurCount;
         if(_loc2_ > MAX_NUMBER)
         {
            _loc2_ = uint(MAX_NUMBER);
         }
         this.FUITrainSoulBox.Value = _loc2_;
      }
      
      protected function SoulNextValueUpdate(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TPetMonsterExp = null;
         var _loc4_:uint = 0;
         if(this.FPetMonsterExp.MonsterLevel < 500)
         {
            _loc3_ = this.FPetMonsterExpBin.GetDatebaseByIdentifier(this.FPet.SoulID + 1) as TPetMonsterExp;
            this.FPet.MonsterNextAddValue = _loc3_.AddValues;
            this.FMC_EnergyBars[param1].SetNextValue = this.FPet.MonsterNextAddValue;
         }
         else
         {
            this.FMC_EnergyBars[param1].SetNextValueView();
         }
      }
      
      protected function SoulCurrentValuUpdate(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TPetMonsterExp = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         _loc3_ = this.FPet.SoulID - TEMPNUMBER - (param1 + 1) * 1000;
         _loc2_ = 0;
         while(_loc2_ < SoulNum)
         {
            if(_loc2_ < param1)
            {
               _loc5_ = TEMPNUMBER + (_loc2_ + 1) * 1000 + _loc3_ + 1;
               _loc4_ = this.FPetMonsterExpBin.GetDatebaseByIdentifier(_loc5_) as TPetMonsterExp;
               if(_loc4_ == null)
               {
                  _loc5_ = TEMPNUMBER + (_loc2_ + 1) * 1000 + _loc3_;
                  _loc4_ = this.FPetMonsterExpBin.GetDatebaseByIdentifier(_loc5_) as TPetMonsterExp;
                  this.FMC_EnergyBars[this.FSoulIndex].SetView = true;
                  this.FMC_EnergyBars[this.FSoulIndex].MCVisible = true;
                  this.FBT_TrainPetSoul.visible = false;
                  this.FBT_BatchTrainSoul.visible = false;
               }
            }
            else
            {
               _loc5_ = TEMPNUMBER + (_loc2_ + 1) * 1000 + _loc3_;
               _loc4_ = this.FPetMonsterExpBin.GetDatebaseByIdentifier(_loc5_) as TPetMonsterExp;
            }
            _loc6_ = _loc4_.AddValues * (1 + this.FPet.AddRate);
            this.FMC_EnergyBars[_loc2_].SetCurrentValue = Math.floor(_loc6_);
            if(this.FPetMonsterExp.MonsterLevel < 500)
            {
               _loc4_ = this.FPetMonsterExpBin.GetDatebaseByIdentifier(this.FPet.SoulID + 1) as TPetMonsterExp;
               _loc6_ = _loc4_.AddValues * (1 + this.FPet.AddRate);
               this.FMC_EnergyBars[_loc2_].SetNextValue = Math.floor(_loc6_);
            }
            _loc2_++;
         }
      }
      
      public function get OnClickTrainSoul() : Function
      {
         return this.FOnClickTrainSoul;
      }
      
      public function set OnClickTrainSoul(param1:Function) : void
      {
         this.FOnClickTrainSoul = param1;
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
      
      public function get LighBoo() : Boolean
      {
         return this.FLighBoo;
      }
      
      public function set LighBoo(param1:Boolean) : void
      {
         this.FLighBoo = param1;
      }
      
      public function get BarBoo() : Boolean
      {
         return this.FBarBoo;
      }
      
      public function set BarBoo(param1:Boolean) : void
      {
         this.FBarBoo = param1;
      }
      
      public function get PetMonsterExpBin() : TBins
      {
         return this.FPetMonsterExpBin;
      }
      
      public function set PetMonsterExpBin(param1:TBins) : void
      {
         this.FPetMonsterExpBin = param1;
      }
      
      public function get PetMonsterBin() : TBins
      {
         return this.FPetMonsterBin;
      }
      
      public function set PetMonsterBin(param1:TBins) : void
      {
         this.FPetMonsterBin = param1;
      }
      
      public function get OnShowBox() : Function
      {
         return this.FOnShowBox;
      }
      
      public function set OnShowBox(param1:Function) : void
      {
         this.FOnShowBox = param1;
      }
      
      public function UpdateSoul() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         this.FPetMonsterExp = this.FPetMonsterExpBin.GetDatebaseByIdentifier(this.FPet.SoulID) as TPetMonsterExp;
         this.FPet.NeedExp = this.FPetMonsterExp.NeedExp;
         this.FPet.MonsterID = this.FPetMonsterExp.MonsterId;
         this.FPet.AddValue = this.FPetMonsterExp.AddValues;
         this.FPet.MonsterLevel = this.FPetMonsterExp.MonsterLevel;
         this.FTF_TotalLevelInner.text = this.FPet.MonsterLevel.toString();
         this.FSoulIndex = (this.FPet.MonsterID - TEMPNUMBER) / 1000 - 1;
         _loc1_ = 0;
         while(_loc1_ < this.FSoulIndex)
         {
            this.FMC_EnergyBars[_loc1_].UpDateExp(this.FPet.NeedExp,this.FPet.NeedExp);
            this.FMC_EnergyBars[_loc1_].SetView = true;
            this.FMC_EnergyBars[_loc1_].ExpVisible = false;
            this.FMC_EnergyBars[_loc1_].SetLevel = this.FPet.MonsterLevel + 1;
            this.FMC_EnergyBars[_loc1_].MCVisible = true;
            this.FMC_EnergyBars[_loc1_].BarrierVisible = true;
            _loc1_++;
         }
         this.FMC_EnergyBars[this.FSoulIndex].UpDateExp(this.FPet.CurrentSoulExp,this.FPet.NeedExp);
         this.FMC_EnergyBars[this.FSoulIndex].SetView = false;
         this.FMC_EnergyBars[this.FSoulIndex].ExpVisible = true;
         this.FMC_EnergyBars[this.FSoulIndex].SetLevel = this.FPet.MonsterLevel;
         this.FMC_EnergyBars[this.FSoulIndex].MCVisible = true;
         this.FMC_EnergyBars[this.FSoulIndex].BarrierVisible = false;
         this.SoulNextValueUpdate(this.FSoulIndex);
         this.SoulCurrentValuUpdate(this.FSoulIndex);
         _loc1_ = this.FSoulIndex + 1;
         while(_loc1_ < SoulNum)
         {
            this.FMC_EnergyBars[_loc1_].UpDateExp(0,this.FPet.NeedExp);
            this.FMC_EnergyBars[_loc1_].SetView = false;
            this.FMC_EnergyBars[_loc1_].ExpVisible = false;
            this.FMC_EnergyBars[_loc1_].SetLevel = this.FPet.MonsterLevel;
            this.FMC_EnergyBars[_loc1_].MCVisible = false;
            this.FMC_EnergyBars[_loc1_].BarrierVisible = true;
            _loc1_++;
         }
         _loc4_ = this.FCharacter.Appliances;
         _loc2_ = uint(_loc4_.Count);
         _loc3_ = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = _loc4_.GetInventoryByIndex(_loc1_);
            if(_loc5_.CategorySecond == FPsychicReel)
            {
               _loc3_ += _loc5_.Quantity;
            }
            _loc1_++;
         }
         this.FTF_RemainNum.text = TUtilityString.Format(STRING_PET.FORMAT_RemainNum,_loc3_);
      }
      
      public function SetLayer() : void
      {
         if(this.FPet.ReviceCount < this.FSetOpenLevel)
         {
            this.FModalLayer.visible = true;
         }
         else
         {
            this.FModalLayer.visible = false;
         }
      }
      
      public function BatchBT() : void
      {
         if(this.FCharacter.VipData.MonsterOneTime)
         {
            this.FBT_BatchTrainSoul.gotoAndStop(RENDERINGSTATE_NORMAL);
            this.FBT_BatchTrainSoul.mouseEnabled = true;
         }
         else
         {
            this.FBT_BatchTrainSoul.gotoAndStop(RENDERINGSTATE_DISABLED);
            this.FBT_BatchTrainSoul.mouseEnabled = false;
         }
      }
   }
}

