package Processors.Game.Lobby.Exercise.TowerLottery
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.TowerLottery.TTowerLottery;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerTowerLottery;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.TowerLottery.Compoents.TUILotteryBox;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class TProcessorTowerLottery extends TProcessorBaseActivity
   {
      
      public static const TYPE_ONE_LOTTERY:int = 1;
      
      public static const TYPE_TEN_LOTTERY:int = 2;
      
      public static const TYPE_GET_GIFT:int = 3;
      
      public static const LAYER_COUNT:int = 9;
      
      public static const TOTAL_BOX:int = 53;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 358;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 67;
      
      protected static const MOVIE_COUNT:int = 8;
      
      protected static const MOVIE_TIME:int = 750;
      
      protected static const MOVIE_ONE:int = 0;
      
      protected static const MOVIE_TEN:int = 1;
      
      protected static const MAX_MOVE_COUNT:int = 1;
      
      protected static const MOVIE_TIMES:Vector.<int> = Vector.<int>([1,2,2,2,2,2,1,1,1]);
      
      public static const LAYER_BOX_COUNT:Vector.<int> = Vector.<int>([10,9,8,7,6,5,4,3,1]);
      
      public static const START_MOVE_BOX_INDEX:Vector.<int> = Vector.<int>([0,10,19,27,34,40,45,49,52]);
      
      public static const END_MOVE_BOX_INDEX:Vector.<int> = Vector.<int>([9,18,26,33,39,44,48,51,52]);
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FTowerLottery:TTowerLottery;
      
      protected var FMC_TowerItems:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FBeClicked:Boolean;
      
      protected var FTowerSlots:TUILotteryBox;
      
      protected var FTowerReward:TUIBaseBox;
      
      protected var FLotteryBtn:MovieClip;
      
      protected var FUnstreamizerTowerLottery:TUnstreamizerTowerLottery;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCurLayer:int;
      
      protected var FCurLotterIndex:Vector.<int>;
      
      protected var FFlowStr:String;
      
      protected var FMC_Movie:MovieClip;
      
      protected var FIsPlayMoveMovie:Boolean;
      
      protected var FCurMoveIndex:int;
      
      protected var FMoveDirection:Boolean;
      
      protected var FFrameCount:int;
      
      protected var FMoveCount:int;
      
      protected var FMovieType:int;
      
      public function TProcessorTowerLottery(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FTowerLottery = SLogicsCore.TowerLottery;
         this.FUnstreamizerTowerLottery = new TUnstreamizerTowerLottery();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBuyBoxDate = new Object();
         this.FTowerSlots = new TUILotteryBox(this,TOTAL_BOX);
         this.FTowerReward = new TUIBaseBox(this,LAYER_COUNT);
         this.FCurLotterIndex = new Vector.<int>();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FMC_TowerItems = TUtilityReflection.CreateDisplayObjectInstance("MC_TowerItems") as MovieClip;
         this.FScrollBar = new TScrollBar(FMC_Scene.mc_list,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.FScrollBar.AddItem(this.FMC_TowerItems);
         this.FTowerSlots.Perform_UIDispatch(this.FMC_TowerItems["MC_Tower"]);
         this.FTowerSlots.OnOverlay = UIComponentsHintOnOver;
         this.FTowerSlots.OnOut = UIComponentsHintOnOut;
         this.FTowerReward.Perform_UIDispatch(this.FMC_TowerItems["MC_Rewards"]);
         this.FTowerReward.OnOverlay = UIComponentsHintOnOver;
         this.FTowerReward.OnOut = UIComponentsHintOnOut;
         this.FTowerReward.OnClick = this.ProcessorOnSlotClick;
         this.FLotteryBtn = FMC_Scene["BTN_Lottery"];
         TGameUtil.setButtonMode(this.FLotteryBtn.BTN_Lottery,true);
         this.FLotteryBtn.BTN_Lottery.addEventListener(MouseEvent.CLICK,this.ProcessorOnBtnLotteryUp);
         if(FMC_Scene.MC_Pet.BTN_PetDesc)
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_Pet.BTN_PetDesc,true);
            FMC_Scene.MC_Pet.BTN_PetDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnPetUp);
         }
         this.FBtn_Close = FMC_Scene["Btn_Close"];
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FInitialized)
         {
            if(Boolean(FMC_Scene) && FMC_Scene.visible)
            {
               this.FTowerSlots.LogicsPerform();
               this.FTowerReward.LogicsPerform();
               if(this.FIsPlayMoveMovie)
               {
                  this.PlayMoveMovie();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateText();
         this.UpdateTower();
         this.UpdateReward();
         this.UpdateBtn();
      }
      
      protected function UpdateTower() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         this.FTowerSlots.UpdateUI(this.FTowerLottery.LotteryInventories);
         this.FTowerReward.UpdateUI(this.FTowerLottery.Inventories);
         _loc1_ = 0;
         while(_loc1_ < this.FTowerLottery.LotteryStatus.length)
         {
            if(this.FTowerLottery.LotteryStatus[_loc1_] == TBaseActivity.STATUS_CANGET)
            {
               _loc5_ = TUIBaseBox.NONE_FILTERS;
            }
            else
            {
               _loc5_ = TUIBaseBox.GARY_COLOR_FILTERS;
            }
            this.FTowerSlots.SetSlotFiltersByIndex(_loc1_,_loc5_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < LAYER_COUNT)
         {
            if(_loc1_ == this.FTowerLottery.CurLayer - 1)
            {
               this.FMC_TowerItems["MC_Select" + _loc1_].visible = true;
            }
            else
            {
               this.FMC_TowerItems["MC_Select" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateReward() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < LAYER_COUNT)
         {
            if(this.FTowerLottery.RewardStatus[_loc1_] == TBaseActivity.STATUS_CANGET)
            {
               this.FTowerReward.MC_Scene["MC_Click" + _loc1_].visible = true;
               this.FTowerReward.MC_Scene["MC_Got" + _loc1_].visible = false;
            }
            else if(this.FTowerLottery.RewardStatus[_loc1_] == TBaseActivity.STATUS_GETED)
            {
               this.FTowerReward.MC_Scene["MC_Click" + _loc1_].visible = false;
               this.FTowerReward.MC_Scene["MC_Got" + _loc1_].visible = true;
            }
            else
            {
               this.FTowerReward.MC_Scene["MC_Click" + _loc1_].visible = false;
               this.FTowerReward.MC_Scene["MC_Got" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         if(this.FTowerLottery.CurLayer >= 5)
         {
            this.FScrollBar.ScrollToUp();
         }
         else
         {
            this.FScrollBar.ScrollToDown();
         }
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.FTowerLottery.GameStatus == TTowerLottery.GAME_STATUS_END)
         {
            FMC_Scene.MC_End.visible = true;
            this.FLotteryBtn.visible = false;
         }
         else
         {
            FMC_Scene.MC_End.visible = false;
            this.FLotteryBtn.visible = true;
         }
         _loc3_ = this.FTowerLottery.LotteryPrice[this.FTowerLottery.CurLayer - 1];
         this.FLotteryBtn.TF_Desc.text = TUtilityString.Format(this.FTowerLottery.DescListNew[1],this.FTowerLottery.CurLayer,_loc3_);
         if(FMC_Scene.MC_Pet)
         {
            if(this.FTowerLottery.PetID == 0)
            {
               FMC_Scene.MC_Pet.visible = false;
            }
            else
            {
               FMC_Scene.MC_Pet.visible = true;
            }
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Desc.htmlText = this.FTowerLottery.DescListNew[0].split("%n%").join("\n");
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FTowerLottery.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FTowerLottery.EndTime) - 1) * 1000)));
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBtnLotteryUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(11));
         if(_loc2_ >= this.FTowerLottery.LotteryPrice.length || this.FIsPlayMoveMovie || this.FTowerLottery.GameStatus == TTowerLottery.GAME_STATUS_END)
         {
            ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT);
            return;
         }
         this.FBuyBoxDate.BoxType = TYPE_ONE_LOTTERY;
         this.FBuyBoxDate.BoxIndex = 0;
         this.FBuyBoxDate.Cost = this.FTowerLottery.LotteryPrice[this.FTowerLottery.CurLayer - 1];
         this.FBuyBoxDate.CostType = TBaseActivity.SWEET_TYPE_GOLD;
         if(!FUIWindowConfirmation.IsSelected)
         {
            if(Boolean(_loc6_) && _loc6_ != "")
            {
               FUIWindowConfirmation.Text = _loc6_;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FBuyBoxDate.Cost);
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
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnSlotClick(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = (param1 as TUIBaseBox).FBoxIndex;
         if(Boolean(this.FTowerLottery) && Boolean(_loc3_ < this.FTowerLottery.RewardStatus.length) && this.FTowerLottery.RewardStatus[_loc3_] == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(TYPE_GET_GIFT,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnPetUp(param1:MouseEvent) : void
      {
         ProcessorOnShowItemDesc(this.FTowerLottery.PetID,TBaseBox.TYPE_IS_PET);
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OrangeEquipment_LoadLogReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnRewardOver(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = int(param1.FBoxIndex);
         if(Boolean(this.FTowerLottery) && _loc3_ < this.FTowerLottery.RewardDescs.length)
         {
            ProcessorOnShowHtmlText(this.FTowerLottery.RewardDescs[_loc3_]);
         }
      }
      
      protected function ProcessorOnRewardOut(param1:Object, param2:Object) : void
      {
         ProcessorOnHideHtmlText();
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FIsPlayMoveMovie)
         {
            return;
         }
         if(FOnClose != null)
         {
            FOnClose(param1);
         }
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
         this.visible = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerTowerLottery.Unstreamize(_loc2_,this.FTowerLottery,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:TLotteryNews = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:TBins = null;
         var _loc17_:TSystemLanguage = null;
         var _loc18_:int = 0;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         this.FTowerLottery.LogList.length = 0;
         _loc5_ = _loc2_.readShort();
         _loc14_ = new Vector.<uint>();
         _loc15_ = new Vector.<uint>();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc10_ = new TLotteryNews();
            _loc14_.length = 0;
            _loc15_.length = 0;
            _loc7_ = int(_loc2_.readUnsignedShort());
            _loc6_ = 0;
            while(_loc6_ < _loc7_ / 5)
            {
               _loc12_ = _loc2_.readUnsignedInt();
               _loc11_ = _loc2_.readUnsignedInt();
               _loc13_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc16_);
               _loc14_.push(_loc13_);
               _loc15_.push(_loc2_.readUnsignedInt());
               _loc10_.GetTime = _loc2_.readUnsignedInt();
               _loc18_ = int(_loc2_.readUnsignedInt());
               if(_loc18_ != 0)
               {
                  _loc17_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc18_) as TSystemLanguage;
                  _loc10_.GetSource = _loc17_.Desc;
               }
               else
               {
                  _loc10_.GetSource = "";
               }
               _loc6_++;
            }
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc14_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc15_[0];
            _loc10_.Inventory = _loc8_;
            _loc10_.Inventories = _loc9_;
            this.FTowerLottery.LogList.push(_loc10_);
            _loc4_++;
         }
         FProcessorWindowLog.BaseActivity = this.FTowerLottery;
         FProcessorWindowLog.UpdateUI();
         FProcessorWindowLog.Visible = true;
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
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case TYPE_ONE_LOTTERY:
               this.FCurLotterIndex.length = 0;
               this.FFlowStr = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc16_ = int(_loc2_.readUnsignedInt());
               _loc5_ = 0;
               while(_loc5_ < _loc16_)
               {
                  _loc10_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc12_ = _loc2_.readUnsignedInt();
                  this.FCurLotterIndex[_loc5_] = _loc2_.readUnsignedInt();
                  this.FFlowStr += STRING_COMMON.GetItemNameByType(_loc10_,_loc11_) + "*" + _loc12_ + "\n";
                  _loc5_++;
               }
               this.FCurLayer = _loc2_.readUnsignedInt();
               this.FTowerLottery.GameStatus = _loc2_.readInt();
               if(this.FCurLayer != this.FTowerLottery.CurLayer || this.FTowerLottery.GameStatus == TTowerLottery.GAME_STATUS_END)
               {
                  this.FTowerLottery.RewardStatus[this.FTowerLottery.CurLayer - 1] = TBaseActivity.STATUS_CANGET;
               }
               this.FMovieType = MOVIE_ONE;
               this.ReseteMovie();
               this.PlayMoveMovie();
               break;
            case TYPE_TEN_LOTTERY:
               break;
            case TYPE_GET_GIFT:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this.FTowerLottery.RewardStatus[_loc5_ - 1] = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FTowerLottery.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function ReseteMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FIsPlayMoveMovie = true;
         this.FCurMoveIndex = START_MOVE_BOX_INDEX[this.FTowerLottery.CurLayer - 1];
         this.FFrameCount = 0;
         this.FMoveCount = 0;
         this.FMoveDirection = true;
         _loc1_ = 0;
         while(_loc1_ < TOTAL_BOX)
         {
            this.FTowerSlots.SetSlotIsShine(_loc1_,false,false);
            this.FTowerSlots.SetCountByIndex(_loc1_);
            _loc1_++;
         }
         this.FTowerSlots.SetSlotIsShine(this.FCurMoveIndex,true,true);
      }
      
      public function PlayMoveMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<int> = null;
         _loc3_ = this.FTowerLottery.CurLayer - 1;
         ++this.FFrameCount;
         if(this.FFrameCount < MOVIE_TIMES[_loc3_])
         {
            return;
         }
         this.FTowerSlots.SetSlotIsShine(this.FCurMoveIndex,false,false);
         if(_loc3_ == LAYER_COUNT - 1)
         {
            ++this.FMoveCount;
            this.FCurMoveIndex = END_MOVE_BOX_INDEX[_loc3_];
         }
         else if(this.FMoveDirection)
         {
            if(this.FCurMoveIndex >= END_MOVE_BOX_INDEX[_loc3_])
            {
               this.FMoveDirection = !this.FMoveDirection;
               --this.FCurMoveIndex;
               ++this.FMoveCount;
            }
            else
            {
               ++this.FCurMoveIndex;
            }
         }
         else if(this.FCurMoveIndex == START_MOVE_BOX_INDEX[_loc3_])
         {
            this.FMoveDirection = !this.FMoveDirection;
            ++this.FCurMoveIndex;
            ++this.FMoveCount;
         }
         else
         {
            --this.FCurMoveIndex;
         }
         this.FFrameCount = 0;
         if(this.FMoveCount >= MAX_MOVE_COUNT)
         {
            if(this.FMovieType == MOVIE_TEN)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FCurLotterIndex.length)
               {
                  _loc4_ = this.FTowerLottery.GetTotalIndexByCurIndex(this.FCurLotterIndex[_loc1_]);
                  this.FTowerSlots.SetSlotIsShine(_loc4_,true,true);
                  _loc1_++;
               }
               this.MovieEnd();
            }
            else
            {
               this.FTowerSlots.SetSlotIsShine(this.FCurMoveIndex,true,true);
               if(this.FCurMoveIndex == this.FTowerLottery.GetTotalIndexByCurIndex(this.FCurLotterIndex[0]))
               {
                  this.MovieEnd();
               }
            }
         }
         else
         {
            this.FTowerSlots.SetSlotIsShine(this.FCurMoveIndex,true,true);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         this.FIsPlayMoveMovie = false;
         if(Boolean(this.FFlowStr) && this.FFlowStr != "")
         {
            ProcessorEffectText(this.FFlowStr);
         }
         _loc2_ = int(this.FCurLotterIndex.length);
         _loc4_ = new Vector.<int>(LAYER_BOX_COUNT[this.FTowerLottery.CurLayer - 1]);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTowerLottery.SetLotteryStatusByCurIndex(this.FCurLotterIndex[_loc1_]);
            _loc3_ = this.FCurLotterIndex[_loc1_] - 1;
            ++_loc4_[_loc3_];
            _loc1_++;
         }
         _loc2_ = LAYER_BOX_COUNT[this.FTowerLottery.CurLayer - 1];
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = START_MOVE_BOX_INDEX[this.FTowerLottery.CurLayer - 1] + _loc1_;
            this.FTowerSlots.SetCountByIndex(_loc3_,_loc4_[_loc1_]);
            _loc1_++;
         }
         this.FTowerLottery.CurLayer = this.FCurLayer;
         this.UpdateUI();
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<String> = Vector.<String>(["Desc1","Desc2","Desc3","Desc4"]);
         var _loc5_:Vector.<int> = Vector.<int>([100022,0,11210009,0,100023,11110071,0]);
         var _loc6_:Vector.<int> = Vector.<int>([1,0,2,0,1,0,0]);
         var _loc7_:Vector.<int> = Vector.<int>([1,0,-1,0,-1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            TUtilityString.FlushUTF(_loc3_,_loc4_[_loc1_]);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(9);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(7);
         _loc3_.writeUnsignedInt(9);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            TUtilityString.FlushUTF(_loc3_,"BTN_DESC1  ");
            TUtilityString.FlushUTF(_loc3_,"BTN_DESC2  ");
            _loc3_.writeInt(3);
            _loc3_.writeInt(1);
            _loc3_.writeInt(9 + _loc1_);
            _loc3_.writeInt(10 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(53);
         _loc1_ = 0;
         while(_loc1_ < 53)
         {
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(9);
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _loc3_.writeInt(_loc1_ % 2);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

