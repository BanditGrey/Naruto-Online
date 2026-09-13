package Processors.Game.Lobby.Exercise.MidAutumn
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TActivityPetConfig;
   import Logics.Exercise.MidAutumn.TMidAutumn;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerBaseInventories;
   import Logics.Streamization.Exercise.TUnstreamizerMidAutumn;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Rendering.Overlayers.MidAutumn.TOverlayerMidAutumn;
   import Rendering.Overlayers.MidAutumn.TOverlayerSimpleSprite;
   import Rendering.Overlayers.Sprite.TOverlayerSprite;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorMidAutumn extends TProcessorBaseActivity
   {
      
      public static const BOX_COUNT:uint = TMidAutumn.BOX_COUNT;
      
      public static const PET_COUNT:uint = TMidAutumn.PET_COUNT;
      
      public static const CHANGE_CHIP_COUNT:int = 0;
      
      public static const CHANGE_BOX_STATUS:int = 1;
      
      public static const CHANGE_PET_STATUS:int = 2;
      
      protected var FMidAutumn:TMidAutumn;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerMidAutumn:TUnstreamizerMidAutumn;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseInventories:TUnstreamizerBaseInventories;
      
      protected var FOverlayerMidAutumn:TOverlayerMidAutumn;
      
      protected var FOverlayerSprite:TOverlayerSprite;
      
      protected var FOverlayerSimpleSprite:TOverlayerSimpleSprite;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FSpriteVect:Vector.<MovieClip>;
      
      protected var FBoxVect:Vector.<MovieClip>;
      
      protected var FTF_FreeCount:TextField;
      
      protected var FSelectedIndex:int;
      
      protected var FActivityPetConfigBins:TBins;
      
      protected var FTitles:TTitles;
      
      public function TProcessorMidAutumn(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FMidAutumn = SLogicsCore.MidAutumn;
         this.FUnstreamizerMidAutumn = new TUnstreamizerMidAutumn();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerBaseInventories = new TUnstreamizerBaseInventories();
         this.FSpriteVect = new Vector.<MovieClip>(BOX_COUNT);
         this.FBoxVect = new Vector.<MovieClip>(BOX_COUNT);
         this.FOverlayerSprite = new TOverlayerSprite(this.Parent);
         this.FOverlayerSprite.Visible = false;
         this.FOverlayerMidAutumn = new TOverlayerMidAutumn(this.Parent);
         this.FOverlayerMidAutumn.Visible = false;
         this.FOverlayerSimpleSprite = new TOverlayerSimpleSprite(this.Parent);
         this.FOverlayerSimpleSprite.Visible = false;
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FTitles = SLogicsCore.Titles;
         this.FAllTitles = new TTitles();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Sprite" + _loc1_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSpriteOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSpriteOut);
            this.FSpriteVect[_loc1_] = _loc4_;
            _loc4_ = FMC_Scene["MC_Box" + _loc1_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc4_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
            this.FBoxVect[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FTF_FreeCount = FMC_Scene.TF_FreeCount;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSprite);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerMidAutumn);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSimpleSprite);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         this.FActivityPetConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityPetConfig);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
         FMC_Scene.MC_Box.addEventListener(MouseEvent.CLICK,this.PerformPacket_CS_GetRewardReq);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFreeBoxOver);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnFreeBoxOut);
         FMC_Scene.MC_Box.buttonMode = true;
         _loc1_ = 0;
         while(_loc1_ < PET_COUNT)
         {
            FMC_Scene["MC_Pet" + _loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnPetUp);
            FMC_Scene["MC_Pet" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPetOver);
            FMC_Scene["MC_Pet" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnPetOut);
            FMC_Scene["MC_Pet" + _loc1_].buttonMode = true;
            _loc1_++;
         }
         FMC_Scene.MC_PetPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSmallPetOver);
         FMC_Scene.MC_PetPic.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSmallPetOut);
         FMC_Scene.MC_Title.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTitleOver);
         FMC_Scene.MC_Title.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTitleOut);
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FInitialized)
         {
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateText();
         this.UpdateSprite();
         this.UpdateBox();
         this.UpdatePet();
      }
      
      protected function UpdateText() : void
      {
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMidAutumn.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMidAutumn.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FMidAutumn.ActivityDesc;
         this.FTF_FreeCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_FREE_LIMIT_TIMES,this.FMidAutumn.FreeTimes);
      }
      
      protected function UpdateSprite() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = this.FSpriteVect[_loc1_];
            _loc2_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc2_.TF_Count.text = this.FMidAutumn.ExchangeInventories.GetInventoryByIndex(_loc1_).Quantity;
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = this.FBoxVect[_loc1_];
            if(this.FMidAutumn.BoxVect[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.MC_Lock.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Buy,false);
            }
            else
            {
               _loc2_.MC_Lock.visible = false;
               TGameUtil.setButtonMode(_loc2_.BTN_Buy,true);
            }
            _loc2_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc2_.TF_Round.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ROUND_COUNT,_loc1_ + 1);
            _loc1_++;
         }
         if(this.FMidAutumn.FreeBoxStatus == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Box.visible = false;
         }
         else
         {
            FMC_Scene.MC_Box.visible = true;
            FMC_Scene.MC_Box.MC_Box.play();
            FMC_Scene.MC_Box.MC_GetBox.play();
         }
      }
      
      protected function UpdatePet() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         var _loc6_:TActivityPetConfig = null;
         var _loc7_:TTitle = null;
         _loc1_ = 0;
         while(_loc1_ < PET_COUNT)
         {
            if(this.FMidAutumn.PetVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               FMC_Scene["MC_Pet" + _loc1_].gotoAndPlay(1);
               FMC_Scene["MC_Pet" + _loc1_].MC_Got.visible = false;
            }
            else if(this.FMidAutumn.PetVect[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               FMC_Scene["MC_Pet" + _loc1_].gotoAndStop(1);
               FMC_Scene["MC_Pet" + _loc1_].MC_Got.visible = false;
            }
            else
            {
               FMC_Scene["MC_Pet" + _loc1_].gotoAndStop(1);
               FMC_Scene["MC_Pet" + _loc1_].MC_Got.visible = true;
            }
            FMC_Scene["MC_Pet" + _loc1_].MC_Pet.gotoAndStop(_loc1_ + 1);
            _loc1_++;
         }
         _loc7_ = this.FAllTitles.GetTitleByIdentifier(this.FMidAutumn.TitleID);
         FMC_Scene["TF_Title1"].text = STRING_BASEACTIVITY.FORMAT_TITLE_ONLY + _loc7_.TitleName;
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         if(this.FMidAutumn)
         {
            FNeedConfig = this.FMidAutumn.NeedConfig;
         }
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         FIndex = int(param1.currentTarget.parent.name.slice(6));
         if(!this.FMidAutumn.BoxVect[FIndex])
         {
            return;
         }
         if(this.FMidAutumn.FreeTimes > 0)
         {
            this.PerformPacket_CS_BuyBoxReq();
         }
         else if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FMidAutumn.BoxVect[FIndex].Price);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         this.FOverlayerMidAutumn.Context = null;
         _loc2_ = int(param1.currentTarget.name.slice(6));
         if(!this.FMidAutumn.BoxVect[_loc2_])
         {
            return;
         }
         this.FOverlayerMidAutumn.Context = this.FMidAutumn.BoxVect[_loc2_];
         this.FOverlayerMidAutumn.Render(FUICore.MouseCoordinate);
         this.FOverlayerMidAutumn.Show();
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         if(!this.FMidAutumn.BoxVect[0])
         {
            return;
         }
         this.FOverlayerMidAutumn.Hide();
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         if(this.FMidAutumn.IsGoldEnough(this.FMidAutumn.BoxVect[FIndex].Price))
         {
            this.FBeClicked = true;
            this.FSelectedIndex = FIndex;
            this.PerformPacket_CS_BuyBoxReq();
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      override protected function PerformPacket_CS_BuyBoxReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override protected function PerformPacket_CS_GetRewardReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnFreeBoxOver(param1:MouseEvent = null) : void
      {
         var _loc2_:TInventory = null;
         if(!this.FMidAutumn.Inventories)
         {
            return;
         }
         _loc2_ = this.FMidAutumn.Inventories.GetInventoryByIndex(0);
         UIComponentsHintOnOver(this,_loc2_);
      }
      
      protected function ProcessorOnFreeBoxOut(param1:MouseEvent = null) : void
      {
         var _loc2_:TInventory = null;
         if(!this.FMidAutumn.Inventories)
         {
            return;
         }
         _loc2_ = this.FMidAutumn.Inventories.GetInventoryByIndex(0);
         UIComponentsHintOnOut(this,_loc2_);
      }
      
      protected function ProcessorOnPetUp(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         FIndex = int(param1.currentTarget.name.slice(6));
         if(this.FMidAutumn.PetVect[FIndex].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_MidAutumn_ExchangePetReq);
         _loc2_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnPetOver(param1:MouseEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TActivityPetConfig = null;
         _loc2_ = int(param1.currentTarget.name.slice(6));
         if(!this.FMidAutumn.PetVect[_loc2_])
         {
            return;
         }
         _loc3_ = uint(this.FMidAutumn.PetVect[_loc2_].Identify);
         _loc4_ = this.FActivityPetConfigBins.GetDatebaseByIdentifier(_loc3_) as TActivityPetConfig;
         this.FOverlayerSprite.Context = null;
         this.FOverlayerSprite.Context = _loc4_;
         this.FOverlayerSprite.Render(FUICore.MouseCoordinate);
         this.FOverlayerSprite.Show();
      }
      
      protected function ProcessorOnPetOut(param1:MouseEvent = null) : void
      {
         if(!this.FMidAutumn.PetVect[0])
         {
            return;
         }
         this.FOverlayerSprite.Hide();
      }
      
      protected function ProcessorOnSpriteOver(param1:MouseEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(param1.currentTarget.name.slice(9));
         if(!this.FMidAutumn.ExchangeInventories)
         {
            return;
         }
         _loc3_ = this.FMidAutumn.ExchangeInventories.GetInventoryByIndex(_loc2_).Name;
         ProcessorOnShowTip(_loc3_);
      }
      
      protected function ProcessorOnSpriteOut(param1:MouseEvent = null) : void
      {
         ProcessorOnHideTip();
      }
      
      protected function ProcessorOnSmallPetOver(param1:MouseEvent = null) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TActivityPetConfig = null;
         if(!this.FMidAutumn.PetVect[2])
         {
            return;
         }
         _loc2_ = uint(this.FMidAutumn.PetVect[2].Identify);
         _loc3_ = this.FActivityPetConfigBins.GetDatebaseByIdentifier(_loc2_) as TActivityPetConfig;
         this.FOverlayerSimpleSprite.Context = null;
         this.FOverlayerSimpleSprite.Context = _loc3_;
         this.FOverlayerSimpleSprite.Render(FUICore.MouseCoordinate);
         this.FOverlayerSimpleSprite.Show();
      }
      
      protected function ProcessorOnSmallPetOut(param1:MouseEvent = null) : void
      {
         this.FOverlayerSimpleSprite.Hide();
      }
      
      protected function ProcessorOnTitleOver(param1:MouseEvent = null) : void
      {
         var _loc2_:TTitle = null;
         _loc2_ = this.FAllTitles.GetTitleByIdentifier(this.FMidAutumn.TitleID);
         if(_loc2_ != null)
         {
            this.FOverlayerTitle.Context = _loc2_;
            this.FOverlayerTitle.Render(FUICore.MouseCoordinate);
            this.FOverlayerTitle.Show();
         }
      }
      
      protected function ProcessorOnTitleOut(param1:MouseEvent = null) : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.alpha = 1;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorOnLoadInfoRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerMidAutumn.Unstreamize(_loc2_,this.FMidAutumn,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorBuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:TInventories = null;
         var _loc11_:String = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc10_ = new TInventories();
         this.FUnstreamizerBaseInventories.Unstreamize(_loc2_,_loc10_,null);
         _loc11_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc7_ = 0;
         while(_loc7_ < _loc10_.Count)
         {
            _loc11_ += _loc10_.GetInventoryByIndex(_loc7_).Name + "*" + _loc10_.GetInventoryByIndex(_loc7_).Quantity + "\n";
            _loc7_++;
         }
         ProcessorEffectText(_loc11_);
         if(this.FMidAutumn.FreeTimes > 0)
         {
            --this.FMidAutumn.FreeTimes;
         }
         this.UpdateUI();
      }
      
      override public function ProcessorGetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
            return;
         }
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
         ProcessorEffectText(_loc4_);
         this.FMidAutumn.FreeBoxStatus = TBaseActivity.STATUS_GETED;
         this.UpdateUI();
         ProcessorCheckEffect(FActivityID,false);
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc2_ = param1.Data;
         if(this.FMidAutumn.BoxVect.length > 0 && this.FMidAutumn.ExchangeInventories.Count > 0)
         {
            _loc3_ = int(_loc2_.readUnsignedShort());
            _loc5_ = int(_loc2_.readUnsignedInt());
            if(_loc5_ == CHANGE_CHIP_COUNT)
            {
               _loc4_ = _loc2_.readUnsignedInt();
               _loc6_ = int(_loc2_.readUnsignedInt());
               this.FMidAutumn.ExchangeInventories.GetInventoryByIndex(_loc4_ - 1).Quantity = _loc6_;
               this.FMidAutumn.CheckChipIsEnough();
            }
            else if(_loc5_ == CHANGE_BOX_STATUS)
            {
               _loc4_ = _loc2_.readUnsignedInt();
               this.FMidAutumn.BoxVect[_loc4_ - 1].Status = TBaseActivity.STATUS_CANGET;
            }
            this.UpdateUI();
         }
      }
      
      override public function ProcessorExchangePet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc8_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
         ProcessorEffectText(_loc8_);
         this.FMidAutumn.PetVect[FIndex].Status = TBaseActivity.STATUS_GETED;
         this.UpdateUI();
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"中秋活动");
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeInt(1);
         _loc3_.writeUnsignedInt(14101044);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(14101054 + _loc1_);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 10000);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(_loc1_ + 1);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(20001);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(_loc1_ + 1);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6 / 3)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

