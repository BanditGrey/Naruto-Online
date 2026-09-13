package Processors.Game.Lobby.Exercise.MoonFestival
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.MoonFestival.TMoonFestival1;
   import Logics.Exercise.MoonFestival.TMoonFestival2;
   import Logics.Exercise.MoonFestival.TMoonFestivalDatas;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerMoonFestival;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorMoonFestival extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_1_WATER_UP:int = 1;
      
      public static const ACTIVITY_1_GET_FRUIT:int = 2;
      
      public static const ACTIVITY_1_GET_GIFT:int = 3;
      
      public static const ACTIVITY_2_EXCHANGE_PET:int = 2;
      
      public static const ACTIVITY_2_EXCHANGE_ITEM:int = 1;
      
      public static const ACTIVITY_2_GET_SWEET:int = 3;
      
      public static const ACTIVITY_2_GET_TEN:int = 4;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var TAB_COUNT:int = 2;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIMoonFestival1,TUIMoonFestival2]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FMoonFestivalDatas:TMoonFestivalDatas;
      
      protected var FUnstreamizerMoonFestival:TUnstreamizerMoonFestival;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FIsOpen:Boolean;
      
      protected var FStrLength:int;
      
      public function TProcessorMoonFestival(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FMoonFestivalDatas = SLogicsCore.MoonFestivalDatas;
         this.FUnstreamizerMoonFestival = new TUnstreamizerMoonFestival(param3);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FTabList = new Vector.<MovieClip>(this.TAB_COUNT);
         this.FChangeTabIndex = 0;
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(this.TAB_COUNT);
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(this.TAB_COUNT);
         this.FOverlayerBox = new TOverlayerBox(this.Parent);
         this.FOverlayerBox.Visible = false;
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FAllTitles = new TTitles();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:TEffectBaseGlowTwo = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            this.FTabList[_loc1_] = FMC_Scene["MC_Tab" + _loc1_];
            this.FTabList[_loc1_].MC_Tab.gotoAndStop(_loc1_ + 1);
            this.FTabList[_loc1_].buttonMode = true;
            this.FTabList[_loc1_].MC_Tab.MC_Selected.visible = false;
            this.FTabList[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChangePage);
            this.FTabList[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTabOver);
            this.FTabList[_loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTabOut);
            this.FTabList[_loc1_].MC_ComingSoon.TF_Date.mouseEnabled = false;
            _loc5_ = new TEffectBaseGlowTwo();
            _loc5_.SetParameters(FMC_Scene["MC_Tab" + _loc1_],FilterColor,FilterGlowWidth,FilterGlowStrength);
            this.FGlowsFilter[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc4_ = this.ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc4_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(FMC_Scene["MC_Activity" + _loc1_]);
            this.FUIWindowVect[_loc1_].OnGetBox = this.ProcessorOnGetBoxUp;
            this.FUIWindowVect[_loc1_].OnBuyBox = this.ProcessorOnBuyBoxUp;
            this.FUIWindowVect[_loc1_].OnNewBoxOver = ProcessorOnNewBoxOver;
            this.FUIWindowVect[_loc1_].OnNewBoxOut = ProcessorOnNewBoxOut;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnShowFlowText = ProcessorEffectText;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnShowRecruit = ProcessorOnShowItemDesc;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            _loc1_++;
         }
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            this.UpdateTabEffect();
            this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
            if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseActivity = null;
         super.UpdateUI();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc2_ = this.FTabList[_loc1_];
            _loc3_ = this.FMoonFestivalDatas.GetActivityByIndex(_loc1_);
            if(_loc3_.IsOpen == TBaseActivity.IS_NOT_OPEN)
            {
               _loc2_.MC_Title.visible = false;
               _loc2_.MC_ComingSoon.visible = true;
               _loc2_.MC_Closed.visible = false;
               _loc2_.MC_ComingSoon.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_OPEN,TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc3_.BeginTime) * 1000)));
            }
            else if(_loc3_.IsOpen == TBaseActivity.IS_OPEN)
            {
               _loc2_.MC_Title.visible = true;
               _loc2_.MC_ComingSoon.visible = false;
               _loc2_.MC_Closed.visible = false;
               _loc2_.MC_Title.gotoAndStop(_loc1_ + 1);
            }
            else
            {
               _loc2_.MC_Title.visible = false;
               _loc2_.MC_ComingSoon.visible = false;
               _loc2_.MC_Closed.visible = true;
            }
            if(_loc1_ == this.FChangeTabIndex)
            {
               _loc2_.MC_Tab.MC_Selected.visible = true;
               this.FUIWindowVect[_loc1_].SetVisible(true);
               this.FUIWindowVect[_loc1_].UpdateUI();
            }
            else
            {
               _loc2_.MC_Tab.MC_Selected.visible = false;
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            if(this.FMoonFestivalDatas.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
            {
               this.FGlowsFilter[_loc1_].IsRunOver = false;
            }
            else
            {
               this.FGlowsFilter[_loc1_].Stop();
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTabEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TEffectBaseGlowTwo = null;
         if(this.FGlowsFilter == null || this.FGlowsFilter[0] == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FGlowsFilter.length)
         {
            _loc2_ = this.FGlowsFilter[_loc1_];
            if(!_loc2_.IsRunOver)
            {
               _loc2_.Run();
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnChangePage(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = this.FMoonFestivalDatas.GetActivityByIndex(_loc2_);
         if(_loc3_.IsOpen != TBaseActivity.IS_OPEN || _loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnTabOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = this.FMoonFestivalDatas.GetActivityByIndex(_loc2_);
         if(_loc3_.ActivityTabName)
         {
            _loc4_ = _loc3_.ActivityTabName.split("%n").join("\n");
            ProcessorOnShowTip(_loc4_);
         }
      }
      
      protected function ProcessorOnTabOut(param1:MouseEvent) : void
      {
         ProcessorOnHideTip();
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:String = "", param7:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxType = param2;
         this.FBuyBoxDate.BoxIndex = param4;
         this.FBuyBoxDate.Cost = param3;
         this.FBuyBoxDate.CostType = param5;
         this.FBuyBoxDate.BoxIndex1 = param7;
         if(param5 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param3;
            if(param6 != "")
            {
               FUIWindowConfirmation.Text = param6;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:int = 0;
         var _loc7_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc7_ = new Vector.<int>();
         _loc7_.push(param2);
         if(param3 != 0)
         {
            _loc7_.push(param3);
         }
         if(param4 != 0)
         {
            _loc7_.push(param4);
         }
         PerformPacket_CS_AllReq(param1,_loc7_);
      }
      
      protected function ProcessorOnTitleOver(param1:uint) : void
      {
         var _loc2_:TTitle = null;
         _loc2_ = this.FAllTitles.GetTitleByIdentifier(param1);
         if(_loc2_ != null)
         {
            this.FOverlayerTitle.Context = _loc2_;
            this.FOverlayerTitle.Render(FUICore.MouseCoordinate);
            this.FOverlayerTitle.Show();
         }
      }
      
      protected function ProcessorOnTitleOut() : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      protected function ProcessorOnShowDesc() : void
      {
         FProcessorWindowDesc.BaseActivity = this.FMoonFestivalDatas.GetActivityByIndex(this.FChangeTabIndex);
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(param1,null);
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(ActivityID);
         _loc1_.Data.writeUnsignedInt(this.FChangeTabIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.FChangeTabIndex = 0;
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         if(this.FUIWindowVect[0])
         {
            this.FUIWindowVect[0].Unmount();
         }
         TweenUtil.removeAllTween();
         this.FChangeTabIndex = 0;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerMoonFestival.Unstreamize(_loc2_,this.FMoonFestivalDatas,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc5_ = this.FMoonFestivalDatas.GetActivityByIdentify(_loc4_) as TBaseActivity;
         ProcessorUnstreamActivityLog(_loc5_,_loc2_);
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TMoonFestival1 = null;
         var _loc10_:TMoonFestival2 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc6_ = _loc2_.readInt();
         switch(_loc6_)
         {
            case ACTIVITY_1_ID:
               _loc9_ = this.FMoonFestivalDatas.GetActivityByIdentify(_loc6_) as TMoonFestival1;
               if(_loc9_)
               {
                  _loc9_.CurGold = _loc2_.readUnsignedInt();
                  _loc9_.WaterCount = _loc2_.readUnsignedInt();
                  this.FMoonFestivalDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FMoonFestivalDatas.CheckStatus());
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_2_ID:
               _loc10_ = this.FMoonFestivalDatas.GetActivityByIdentify(_loc6_) as TMoonFestival2;
         }
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:int = 0;
         var _loc14_:uint = 0;
         var _loc15_:TBaseBox = null;
         var _loc16_:uint = 0;
         var _loc17_:TBins = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:Vector.<Object> = null;
         var _loc23_:TConfigValue = null;
         var _loc24_:TMoonFestival1 = null;
         var _loc25_:TMoonFestival2 = null;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:Vector.<uint> = null;
         var _loc31_:Vector.<uint> = null;
         var _loc32_:String = null;
         var _loc33_:TSystemLanguage = null;
         this.FBeClicked = false;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc23_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc22_ = _loc23_.Value as Vector.<Object>;
         _loc30_ = new Vector.<uint>();
         _loc31_ = new Vector.<uint>();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         _loc10_ = _loc2_.readUnsignedInt();
         switch(_loc7_)
         {
            case ACTIVITY_1_ID:
               _loc24_ = this.FMoonFestivalDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TMoonFestival1;
               if(_loc10_ == ACTIVITY_1_WATER_UP)
               {
                  if(_loc24_.WaterCount > 0)
                  {
                     --_loc24_.WaterCount;
                  }
                  _loc24_.NextTime = _loc2_.readUnsignedInt();
                  _loc4_ = _loc24_.DescListNew[2].split("%n").join("\n");
                  _loc4_ = TUtilityString.Format(_loc4_,_loc24_.WaterReduceTime);
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FMoonFestivalDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FMoonFestivalDatas.CheckStatus());
                  this.FUIWindowVect[0].PlayMovie(TUIMoonFestival1.MOVIE_TYPE_WATER);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_FRUIT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.FruitStatus[_loc5_] = TBaseActivity.STATUS_GETED;
                  _loc24_.NextTime = _loc2_.readUnsignedInt();
                  _loc24_.TreeLevel = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc9_ = _loc24_.FruitList.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc18_ = int(_loc2_.readUnsignedInt());
                  if(_loc18_ > 0)
                  {
                     _loc30_.length = 0;
                     _loc31_.length = 0;
                     _loc24_.FruitStatus.length = 0;
                     _loc8_ = new TInventories();
                     _loc6_ = 0;
                     while(_loc6_ < _loc18_)
                     {
                        _loc16_ = _loc2_.readUnsignedInt();
                        _loc11_ = _loc2_.readUnsignedInt();
                        _loc12_ = CONST_COMMON.GetItemIDByType(_loc16_,_loc11_,_loc17_);
                        _loc30_.push(_loc12_);
                        _loc31_.push(_loc2_.readUnsignedInt());
                        _loc24_.FruitStatus.push(TBaseActivity.STATUS_CANNOTGET);
                        _loc6_++;
                     }
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc30_);
                     _loc6_ = 0;
                     while(_loc6_ < _loc18_)
                     {
                        _loc9_ = _loc8_.GetInventoryByIndex(_loc6_);
                        _loc9_.Quantity = _loc31_[_loc6_];
                        _loc6_++;
                     }
                     _loc24_.FruitList = _loc8_;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FMoonFestivalDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FMoonFestivalDatas.CheckStatus());
                  if(_loc24_.TreeLevel == -1)
                  {
                     this.FUIWindowVect[0].PlayMovie(TUIMoonFestival1.MOVIE_TYPE_TREE);
                     _loc24_.FruitStatus.length = 0;
                     _loc24_.FruitList = new TInventories();
                  }
                  UIComponentsHintOnOut(this,null);
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc18_ = int(_loc2_.readUnsignedInt());
                  _loc6_ = 0;
                  while(_loc6_ < _loc18_)
                  {
                     _loc16_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc13_ = int(_loc2_.readUnsignedInt());
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc13_ + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FMoonFestivalDatas.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FMoonFestivalDatas.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc25_ = this.FMoonFestivalDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TMoonFestival2;
               if(_loc10_ == ACTIVITY_2_GET_SWEET)
               {
                  if(_loc25_.Count > 0)
                  {
                     --_loc25_.Count;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc14_ = _loc2_.readUnsignedInt();
                  _loc25_.ShopExchangePoint += _loc14_;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  if(_loc14_ > 0)
                  {
                     _loc4_ += _loc25_.DescListNew[8] + "*" + _loc14_ + "\n";
                  }
                  _loc5_ = 0;
                  while(_loc5_ < _loc25_.SweetList.length)
                  {
                     _loc25_.SweetList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FMoonFestivalDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FMoonFestivalDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_TEN)
               {
                  _loc25_.AmountList.length = 0;
                  _loc25_.IndexList.length = 0;
                  _loc25_.StatusList.length = 0;
                  _loc5_ = 0;
                  while(_loc5_ < 10)
                  {
                     _loc25_.AmountList[_loc5_] = _loc2_.readUnsignedInt();
                     _loc25_.IndexList[_loc5_] = _loc2_.readUnsignedInt();
                     _loc25_.StatusList[_loc5_] = _loc2_.readInt();
                     _loc5_++;
                  }
                  if(Boolean(FMC_Scene) && Boolean(this.visible) && this.FIsOpen)
                  {
                     this.FUIWindowVect[1].PlayMovie();
                  }
               }
               else if(_loc10_ == ACTIVITY_2_EXCHANGE_PET)
               {
                  _loc25_.ShopExchangePoint -= _loc25_.Pet.Price;
                  _loc25_.Pet.Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  _loc25_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FMoonFestivalDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FMoonFestivalDatas.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc25_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  --_loc25_.ShopExchangeItems[_loc5_].LimitCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  _loc25_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FMoonFestivalDatas.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FMoonFestivalDatas.CheckStatus());
                  this.UpdateUI();
               }
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(8);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"浇水成功%n成熟时间减少%0分钟");
         TUtilityString.FlushUTF(_loc3_,"已满级");
         TUtilityString.FlushUTF(_loc3_,"登陆送奖励");
         TUtilityString.FlushUTF(_loc3_,"每日充值送奖励");
         TUtilityString.FlushUTF(_loc3_,"TIP0");
         TUtilityString.FlushUTF(_loc3_,"TIP1");
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(200);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTime() + 10);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(1);
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
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(9);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"一键探索TIPS");
         TUtilityString.FlushUTF(_loc3_,"TIP1");
         TUtilityString.FlushUTF(_loc3_,"TIP2");
         TUtilityString.FlushUTF(_loc3_,"TIP3");
         TUtilityString.FlushUTF(_loc3_,"TIP4");
         TUtilityString.FlushUTF(_loc3_,"TIP5");
         TUtilityString.FlushUTF(_loc3_,"活动道具名称");
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(100043);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeShort(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

