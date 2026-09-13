package Processors.Game.GroupBattle
{
   import Components.Slots.*;
   import Foundation.Queries.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.GroupBattle.*;
   import Logics.Inventories.*;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TGroupBattleWindowWin extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:uint = 3;
      
      protected static const MAX_ITEM_COUNT:uint = 5;
      
      protected var FScene:MovieClip;
      
      protected var FTF_Sure:TextField;
      
      protected var FPlayerHeadBitmapVect:Vector.<Bitmap>;
      
      protected var FUISlots:Vector.<Vector.<TUISlot>>;
      
      protected var FLastTime:uint;
      
      protected var FCloseTime:uint;
      
      protected var FInventoriesVect:Vector.<TInventories>;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FGroupBattleRewardsVect:Vector.<TGroupBattleRewards>;
      
      protected var FPageIndex:Vector.<uint>;
      
      protected var FPageMax:Vector.<uint>;
      
      protected var FHeroIds:Vector.<uint>;
      
      protected var FSlotsOnMove:Function;
      
      protected var FSlotsOnOut:Function;
      
      public function TGroupBattleWindowWin(param1:TUIComponent)
      {
         super(param1);
         this.FHeroIds = new Vector.<uint>();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(Visible)
         {
            _loc1_ = this.FCloseTime - STimingCore.GetServerTick();
            this.FTF_Sure.text = TUtilityString.Format(STRING_GROUPBATTLE.STRING_SURE_BACK,_loc1_);
            if(_loc1_ <= 0)
            {
               ProcessorWindowClose();
            }
         }
      }
      
      protected function InitWindow() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Bitmap = null;
         var _loc5_:Vector.<TUISlot> = null;
         var _loc6_:TUISlot = null;
         var _loc7_:TConfigValue = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_GroupBattle_Win) as MovieClip;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene["BTN_OK"],true);
         this.FScene["BTN_OK"].addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FTF_Sure = this.FScene["BTN_OK"]["TF_Sure"];
         this.FScene.x = (FUICore.StageWidth - this.FScene.width) / 2;
         this.FScene.y = (FUICore.StageHeight - this.FScene.height) / 2;
         this.FPlayerHeadBitmapVect = new Vector.<Bitmap>(MAX_COUNT);
         this.FUISlots = new Vector.<Vector.<TUISlot>>(MAX_COUNT);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc4_ = new Bitmap();
            this.FScene["MC_Player" + _loc1_]["MC_Head"]["MC_Head"].addChild(_loc4_);
            this.FPlayerHeadBitmapVect[_loc1_] = _loc4_;
            TGameUtil.setButtonMode(this.FScene["MC_Player" + _loc1_]["btn_left"],true);
            TGameUtil.setButtonMode(this.FScene["MC_Player" + _loc1_]["btn_right"],true);
            this.FScene["MC_Player" + _loc1_]["btn_left"].addEventListener(MouseEvent.CLICK,this.OnLeftClick);
            this.FScene["MC_Player" + _loc1_]["btn_right"].addEventListener(MouseEvent.CLICK,this.OnRightClick);
            _loc5_ = new Vector.<TUISlot>(MAX_ITEM_COUNT);
            _loc2_ = 0;
            while(_loc2_ < MAX_ITEM_COUNT)
            {
               _loc6_ = this.GetSlot();
               _loc6_.Resource = this.FScene["MC_Player" + _loc1_]["mc_slot_" + _loc2_];
               _loc6_.Init();
               _loc5_[_loc2_] = _loc6_;
               _loc2_++;
            }
            this.FUISlots[_loc1_] = _loc5_;
            _loc1_++;
         }
         this.FInventoriesVect = new Vector.<TInventories>(MAX_COUNT);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FInventoriesVect[_loc1_] = new TInventories();
            _loc1_++;
         }
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FPageIndex = new Vector.<uint>(MAX_COUNT);
         this.FPageMax = new Vector.<uint>(MAX_COUNT);
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GROUPBATTLE_OutTime) as TConfigValue;
         this.FLastTime = _loc7_.Value as uint;
      }
      
      protected function GetSlot() : TUISlot
      {
         var _loc1_:TUISlot = null;
         _loc1_ = new TUISlot(this);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc1_.OnOverlay = this.FSlotsOnMove;
         _loc1_.OnOut = this.FSlotsOnOut;
         _loc1_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         _loc1_.OnQuerySubscript = this.SlotsOnQuerySubscript;
         return _loc1_;
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_GroupBattle);
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
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGroupBattleRewards = null;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:TInventories = null;
         var _loc7_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            if(_loc1_ >= this.FGroupBattleRewardsVect.length)
            {
               this.FScene["MC_Player" + _loc1_].visible = false;
            }
            else
            {
               _loc3_ = this.FGroupBattleRewardsVect[_loc1_];
               this.FScene["MC_Player" + _loc1_]["TF_Name"].text = _loc3_.UserName;
               this.FScene["MC_Player" + _loc1_]["TF_Level"].text = SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(_loc3_.UserLevel);
               this.FScene["MC_Player" + _loc1_]["TF_Reward"].text = STRING_COMMON.ITEMNAME_Exp + ":" + _loc3_.NormalRewards.Exp + "\t" + STRING_COMMON.ITEMNAME_Coin + ":" + _loc3_.NormalRewards.Money;
               _loc4_ = _loc3_.NormalRewards.ItemIDWithOutExpMoney;
               _loc5_ = _loc3_.NormalRewards.ItemQuantityWithOutExpMoney;
               _loc6_ = this.FInventoriesVect[_loc1_];
               _loc6_.Clear();
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc6_,_loc4_);
               _loc2_ = 0;
               while(_loc2_ < _loc6_.Count)
               {
                  _loc7_ = _loc6_.GetInventoryByIndex(_loc2_);
                  _loc7_.Quantity = _loc5_[_loc2_];
                  _loc2_++;
               }
               this.FPageMax[_loc1_] = Math.max(_loc6_.Count - MAX_ITEM_COUNT,0);
               this.FScene["MC_Player" + _loc1_].visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdataInventorie() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Vector.<TUISlot> = null;
         var _loc4_:TInventories = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            if(_loc1_ >= this.FGroupBattleRewardsVect.length)
            {
               this.FScene["MC_Player" + _loc1_].visible = false;
            }
            else
            {
               _loc4_ = this.FInventoriesVect[_loc1_];
               _loc3_ = this.FUISlots[_loc1_];
               _loc2_ = 0;
               while(_loc2_ < MAX_ITEM_COUNT)
               {
                  if(_loc2_ + this.FPageIndex[_loc1_] >= _loc4_.Count)
                  {
                     _loc3_[_loc2_].Context = null;
                  }
                  else
                  {
                     _loc3_[_loc2_].Context = _loc4_.GetInventoryByIndex(_loc2_ + this.FPageIndex[_loc1_]);
                  }
                  _loc2_++;
               }
               this.FScene["MC_Player" + _loc1_].visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function CheckBtn() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FScene["MC_Player" + _loc1_]["btn_left"].visible = Boolean(this.FPageIndex[_loc1_] != 0);
            this.FScene["MC_Player" + _loc1_]["btn_right"].visible = Boolean(this.FPageMax[_loc1_] != this.FPageIndex[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function OnLeftClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = uint(int(String(param1.target.parent.name).slice(9)));
         --this.FPageIndex[_loc2_];
         if(this.FPageIndex[_loc2_] < 0)
         {
            this.FPageIndex[_loc2_] = 0;
         }
         this.UpdataInventorie();
         this.CheckBtn();
      }
      
      protected function OnRightClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = uint(int(String(param1.target.parent.name).slice(9)));
         ++this.FPageIndex[_loc2_];
         if(this.FPageIndex[_loc2_] >= this.FPageMax[_loc2_])
         {
            this.FPageIndex[_loc2_] = this.FPageMax[_loc2_];
         }
         this.UpdataInventorie();
         this.CheckBtn();
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(this.FScene != null && param1)
         {
            this.FScene["MC_Title"]["MC_Title"].gotoAndPlay(1);
            this.FCloseTime = STimingCore.GetServerTick() + this.FLastTime;
         }
      }
      
      public function set SlotsOnMove(param1:Function) : void
      {
         this.FSlotsOnMove = param1;
      }
      
      public function get SlotsOnMove() : Function
      {
         return this.FSlotsOnMove;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      public function get SlotsOnOut() : Function
      {
         return this.FSlotsOnOut;
      }
      
      public function SetGroupBattleWinRewards(param1:Vector.<TGroupBattleRewards>) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TRoleModel = null;
         this.FGroupBattleRewardsVect = param1;
         this.FHeroIds.length = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FGroupBattleRewardsVect.length)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,this.FGroupBattleRewardsVect[_loc2_].ModelId) as TRoleModel;
            this.FHeroIds.push(_loc4_.RoleHead);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            this.FPageIndex[_loc2_] = 0;
            _loc2_++;
         }
         this.UpdataUI();
         this.UpdataInventorie();
         this.CheckBtn();
      }
      
      public function Updata() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Vector.<TUISlot> = null;
         _loc2_ = this.FHeroIds.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FPlayerHeadBitmapVect[_loc1_],CONST_MODULES.MODULE_GroupBattle,this.FHeroIds[_loc1_]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc4_ = this.FUISlots[_loc1_];
            _loc3_ = 0;
            while(_loc3_ < MAX_ITEM_COUNT)
            {
               _loc4_[_loc3_].Update();
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function Init() : void
      {
         this.InitWindow();
      }
   }
}

