package Processors.Game.Lobby.Undertown.LittlePanel
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TDailyTaskReward;
   import Logics.DatebaseVO.VO.TDungeonsBattle;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Undertown.TUndertownLogicData;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class LittleThreePanel extends Sprite
   {
      
      public static const Length:int = 2;
      
      protected var FParent:TUIComponent;
      
      protected var FTempPanel:MovieClip;
      
      protected var FMC_Icon:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FTUISlotVector:Vector.<TUISlot>;
      
      protected var FMC_GoIn_Fighting:MovieClip;
      
      protected var FMC_Back_Btn:MovieClip;
      
      protected var FTF_FirstKill_Name:TextField;
      
      protected var FTF_FirstKill_Time:TextField;
      
      protected var FMC_RewardsIcon:MovieClip;
      
      protected var FTF_SecondtKill_Name:TextField;
      
      protected var FTF_ThirdtKill_Name:TextField;
      
      protected var FTF_Recommend:TextField;
      
      protected var FMC_Got:MovieClip;
      
      protected var FMC_GetReward:MovieClip;
      
      protected var FEffectMC_RewardIcon:MovieClip;
      
      protected var FNimeiMove:Function;
      
      protected var FNimeiOver:Function;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FSelectMaterialInventories:TInventories;
      
      protected var ExpendMaterialCount:Vector.<int>;
      
      protected var FMC_GoIn_FightingFunction:Function;
      
      protected var FMC_Back_BtnFunction:Function;
      
      protected var FGetRewardFunction:Function;
      
      protected var FSlotsOnOverBackFunction:Function;
      
      protected var FSlotsOnOutBackFunction:Function;
      
      protected var FSlotsOnQuerySequenceContextBackFunction:Function;
      
      protected var FLogicData:TUndertownLogicData = null;
      
      protected var FThisData:TDungeonsBattle;
      
      protected var bmp:Bitmap;
      
      protected var FCurPageIndex:int;
      
      protected var FMC_UpBtn:MovieClip;
      
      protected var FMC_DownBtn:MovieClip;
      
      public function LittleThreePanel(param1:TUIComponent)
      {
         super();
         this.FParent = param1;
         this.FTUISlotVector = new Vector.<TUISlot>(Length);
         this.bmp = new Bitmap();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSelectInventories = new TInventories();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectMaterialInventories = new TInventories();
         this.ExpendMaterialCount = new Vector.<int>();
      }
      
      protected function UpdateReward() : void
      {
         var _loc1_:int = 0;
         var _loc3_:TDailyTaskReward = null;
         var _loc4_:TInventory = null;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.length = 0;
         this.ExpendMaterialCount.length = 0;
         var _loc2_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc1_ = 0;
         while(_loc1_ < this.FThisData.BaseAwardVect.length)
         {
            _loc3_ = this.FThisData.BaseAwardVect[_loc1_];
            this.FTempSelectInventoriesId.push(CONST_COMMON.GetItemIDByType(_loc3_.Type,_loc3_.Code,_loc2_));
            this.ExpendMaterialCount.push(_loc3_.Amount);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FThisData.RandomAward2Vect.length)
         {
            _loc3_ = this.FThisData.RandomAward2Vect[_loc1_];
            this.FTempSelectInventoriesId.push(CONST_COMMON.GetItemIDByType(_loc3_.Type,_loc3_.Code,_loc2_));
            this.ExpendMaterialCount.push(_loc3_.Amount);
            _loc1_++;
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         _loc1_ = 0;
         while(_loc1_ < this.FSelectInventories.Count)
         {
            _loc4_ = this.FSelectInventories.GetInventoryByIndex(_loc1_);
            _loc4_.Quantity = this.ExpendMaterialCount[_loc1_];
            _loc1_++;
         }
         this.FCurPageIndex = 0;
         this.Checkindex();
         this.SetValueByInventory();
      }
      
      protected function SetValueByInventory() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < Length)
         {
            if(_loc1_ < this.FSelectInventories.Count)
            {
               _loc2_ = _loc1_ + this.FCurPageIndex * Length;
               this.FTUISlotVector[_loc1_].Context = this.FSelectInventories.GetInventoryByIndex(_loc2_);
            }
            else
            {
               this.FTUISlotVector[_loc1_].Context = null;
            }
            _loc1_++;
         }
      }
      
      public function set TempPanel(param1:MovieClip) : void
      {
         this.FTempPanel = param1;
         addChild(this.FTempPanel);
         this.UIDispatch();
      }
      
      protected function UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         _loc1_ = 0;
         while(_loc1_ < Length)
         {
            _loc2_ = new TUISlot(this.FParent);
            _loc2_.Resource = this.FTempPanel["MC_Slot_" + _loc1_];
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.OnOverlay = this.SlotsOnOver;
            _loc2_.OnOut = this.SlotsOnOut;
            _loc2_.Init();
            this.FTUISlotVector[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.FMC_Icon = this.FTempPanel["MC_MonsterIcon"]["MC_Icon"];
         this.FMC_Icon.addChild(this.bmp);
         this.FTF_Name = this.FTempPanel["TF_Name"];
         this.FMC_GoIn_Fighting = this.FTempPanel["MC_GoIn_Fighting"];
         this.FMC_Back_Btn = this.FTempPanel["MC_Back_Btn"];
         TGameUtil.setButtonMode(this.FMC_Back_Btn,true);
         TGameUtil.setButtonMode(this.FMC_GoIn_Fighting,true);
         this.FMC_GoIn_Fighting.addEventListener(MouseEvent.CLICK,this.BtnClisk);
         this.FMC_Back_Btn.addEventListener(MouseEvent.CLICK,this.BtnClisk);
         this.FTF_FirstKill_Name = this.FTempPanel["TF_FirstKill_Name"];
         this.FTF_FirstKill_Time = this.FTempPanel["TF_FirstKill_Time"];
         this.FMC_RewardsIcon = this.FTempPanel["MC_RewardsIcon"];
         this.FTF_SecondtKill_Name = this.FTempPanel["TF_SecondtKill_Name"];
         this.FTF_ThirdtKill_Name = this.FTempPanel["TF_ThirdtKill_Name"];
         this.FTF_Recommend = this.FTempPanel["TF_Recommend"];
         this.FMC_Got = this.FMC_RewardsIcon["MC_Got"];
         this.FMC_Got.mouseEnabled = false;
         this.FMC_GetReward = this.FMC_RewardsIcon["MC_GetReward"];
         this.FEffectMC_RewardIcon = this.FMC_RewardsIcon["MC_RewardIcon"];
         this.FMC_UpBtn = this.FTempPanel["MC_UpBtn"];
         this.FMC_DownBtn = this.FTempPanel["MC_DownBtn"];
         this.FMC_UpBtn.addEventListener(MouseEvent.CLICK,this.BtnClisk);
         this.FMC_DownBtn.addEventListener(MouseEvent.CLICK,this.BtnClisk);
         this.FEffectMC_RewardIcon.addEventListener(MouseEvent.CLICK,this.BtnClisk);
         this.FMC_RewardsIcon.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnMove);
         this.FMC_RewardsIcon.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOver);
      }
      
      public function set NimeiMove(param1:Function) : void
      {
         this.FNimeiMove = param1;
      }
      
      public function set NimeiOver(param1:Function) : void
      {
         this.FNimeiOver = param1;
      }
      
      protected function BtnMove(param1:MouseEvent) : void
      {
         if(this.FNimeiMove != null)
         {
            this.FNimeiMove(this.FThisData);
         }
      }
      
      protected function BtnOver(param1:MouseEvent) : void
      {
         if(this.FNimeiOver != null)
         {
            this.FNimeiOver();
         }
      }
      
      protected function BtnClisk(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_GoIn_Fighting:
               if(!this.FMC_GoIn_Fighting.buttonMode)
               {
                  return;
               }
               if(this.FMC_GoIn_FightingFunction != null)
               {
                  this.FMC_GoIn_FightingFunction();
               }
               break;
            case this.FMC_Back_Btn:
               if(!this.FMC_Back_Btn.buttonMode)
               {
                  return;
               }
               if(this.FMC_Back_BtnFunction != null)
               {
                  this.FMC_Back_BtnFunction();
               }
               break;
            case this.FEffectMC_RewardIcon:
               if(!this.FEffectMC_RewardIcon.buttonMode)
               {
                  return;
               }
               if(this.FGetRewardFunction != null)
               {
                  this.FGetRewardFunction(this.FThisData.Identifier);
               }
               break;
            case this.FMC_UpBtn:
               --this.FCurPageIndex;
               this.Checkindex();
               this.SetValueByInventory();
               break;
            case this.FMC_DownBtn:
               ++this.FCurPageIndex;
               this.Checkindex();
               this.SetValueByInventory();
         }
      }
      
      protected function Checkindex() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         TGameUtil.setButtonMode(this.FMC_UpBtn,true);
         TGameUtil.setButtonMode(this.FMC_DownBtn,true);
         if(this.FCurPageIndex <= 0)
         {
            this.FCurPageIndex = 0;
            TGameUtil.setButtonMode(this.FMC_UpBtn,false);
         }
         _loc1_ = this.FCurPageIndex + Length;
         _loc2_ = this.FSelectInventories.Count;
         if(_loc1_ >= _loc2_)
         {
            this.FCurPageIndex = _loc2_ - Length;
            TGameUtil.setButtonMode(this.FMC_DownBtn,false);
         }
      }
      
      public function UpdateView() : void
      {
         this.FTF_Name.text = this.FThisData.BossName;
         this.FTF_Recommend.text = this.FThisData.Description;
      }
      
      public function S_C_GetPaiMing(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:Date = null;
         var _loc11_:String = null;
         _loc3_ = param1.readUnsignedInt();
         _loc2_ = param1.readShort();
         if(_loc2_ == 0)
         {
            this.FTF_FirstKill_Name.text = "";
            this.FTF_FirstKill_Time.text = "";
            this.FTF_SecondtKill_Name.text = "";
            this.FTF_ThirdtKill_Name.text = "";
            this.SetFMC_RewardsIconState(0);
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_ = int(param1.readUnsignedByte());
               _loc3_ = param1.readUnsignedByte();
               _loc6_ = param1.readUnsignedInt();
               _loc7_ = param1.readUnsignedInt();
               _loc8_ = param1.readUnsignedInt();
               _loc9_ = TUtilityString.FetchUTF(param1);
               switch(_loc4_)
               {
                  case 0:
                     if(_loc6_ == SLogicsCore.Character.Identifier0 && _loc7_ == SLogicsCore.Character.Identifier1)
                     {
                        if(_loc5_)
                        {
                           this.SetFMC_RewardsIconState(1);
                        }
                        else
                        {
                           this.SetFMC_RewardsIconState(2);
                        }
                     }
                     else
                     {
                        this.SetFMC_RewardsIconState(0);
                     }
                     _loc10_ = new Date(STimingCore.GetClientShowTime(_loc8_) * 1000);
                     _loc11_ = TUtilityDate.FormatDateChineseNewCopy(_loc10_);
                     this.FTF_FirstKill_Time.text = _loc11_;
                     this.FTF_FirstKill_Name.text = _loc9_;
                     break;
                  case 1:
                     this.FTF_SecondtKill_Name.text = _loc9_;
                     this.SetFMC_RewardsIconState(0);
                     break;
                  case 2:
                     this.FTF_ThirdtKill_Name.text = _loc9_;
                     this.SetFMC_RewardsIconState(0);
               }
               _loc4_++;
            }
            if(_loc2_ == 1)
            {
               this.FTF_SecondtKill_Name.text = "";
               this.FTF_ThirdtKill_Name.text = "";
            }
            if(_loc2_ == 2)
            {
               this.FTF_ThirdtKill_Name.text = "";
            }
         }
      }
      
      protected function SetFMC_RewardsIconState(param1:int) : void
      {
         this.FMC_RewardsIcon.filters = [];
         this.FMC_Got.visible = false;
         this.FMC_GetReward.visible = false;
         this.FMC_GetReward.buttonMode = true;
         this.FEffectMC_RewardIcon.gotoAndStop(1);
         this.FEffectMC_RewardIcon.buttonMode = true;
         switch(param1)
         {
            case 0:
               this.FMC_RewardsIcon.filters = [TGameUtil.darkFilters];
               this.FMC_GetReward.buttonMode = false;
               this.FEffectMC_RewardIcon.buttonMode = false;
               break;
            case 1:
               this.FMC_Got.visible = true;
               this.FMC_RewardsIcon.filters = [TGameUtil.darkFilters];
               this.FMC_GetReward.buttonMode = false;
               this.FEffectMC_RewardIcon.buttonMode = false;
               break;
            case 2:
               this.FMC_GetReward.buttonMode = true;
               this.FEffectMC_RewardIcon.gotoAndPlay(1);
         }
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(!this.FThisData)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.bmp,CONST_MODULES.MODULE_Undertown,this.FThisData.Image);
         _loc1_ = 0;
         while(_loc1_ < Length)
         {
            this.FTUISlotVector[_loc1_].Update();
            _loc1_++;
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FSlotsOnOverBackFunction != null)
         {
            this.FSlotsOnOverBackFunction(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FSlotsOnOutBackFunction != null)
         {
            this.FSlotsOnOutBackFunction(param1,param2);
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         if(this.FSlotsOnQuerySequenceContextBackFunction != null)
         {
            this.FSlotsOnQuerySequenceContextBackFunction(param2,param3,param4);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      public function set SlotsOnQuerySequenceContextBackFunction(param1:Function) : void
      {
         this.FSlotsOnQuerySequenceContextBackFunction = param1;
      }
      
      public function set SlotsOnOutBackFunction(param1:Function) : void
      {
         this.FSlotsOnOutBackFunction = param1;
      }
      
      public function set SlotsOnOverBackFunction(param1:Function) : void
      {
         this.FSlotsOnOverBackFunction = param1;
      }
      
      public function set ThisData(param1:TDungeonsBattle) : void
      {
         this.FThisData = param1;
         this.UpdateReward();
      }
      
      public function set LogicData(param1:TUndertownLogicData) : void
      {
         this.FLogicData = param1;
      }
      
      public function set MC_GoIn_FightingFunction(param1:Function) : void
      {
         this.FMC_GoIn_FightingFunction = param1;
      }
      
      public function set MC_Back_BtnFunction(param1:Function) : void
      {
         this.FMC_Back_BtnFunction = param1;
      }
      
      public function set GetRewardFunction(param1:Function) : void
      {
         this.FGetRewardFunction = param1;
      }
   }
}

