package Processors.Game.Lobby.TheWorldTree.LittlePanel
{
   import Components.Slots.TUISlot;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.TheWorldTree.TTheWorldTreeLogicData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_THEWORLDTREE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TPressorWindowCanWuJieSuanPopBuyFream extends TProcessorLobbyWindow
   {
      
      public static const FIVE:int = 6;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FMC_CloseBtn:SimpleButton;
      
      protected var FTF_TreeLevel:TextField;
      
      protected var FTF_CanWuTime:TextField;
      
      protected var FTF_BaseExp:TextField;
      
      protected var FTF_AllExp_Dec:TextField;
      
      protected var FTF_TheWorldPower:TextField;
      
      protected var FMC_OnLineTime:MovieClip;
      
      protected var FMC_HuiYeZhiLi:MovieClip;
      
      protected var FMC_Vip:MovieClip;
      
      protected var FMC_DaoJuDiaoLuo:MovieClip;
      
      protected var FMC_JingYnaJaiCeng:MovieClip;
      
      protected var FTF_WanOuNum:TextField;
      
      protected var FMC_SlotArea:MovieClip;
      
      protected var FMC_SureBtn:MovieClip;
      
      protected var FBTN_Left:MovieClip;
      
      protected var FBTN_Right:MovieClip;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FTempSelectInventoriesCount:Vector.<uint>;
      
      protected var CurPageIndex:int;
      
      protected var FFiveSlot:Vector.<TUISlot> = null;
      
      protected var FDaoJuVec:Vector.<uint>;
      
      protected var FLogicDate:TTheWorldTreeLogicData;
      
      protected var FSureBtnBackFun:Function;
      
      public function TPressorWindowCanWuJieSuanPopBuyFream(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.FFiveSlot = new Vector.<TUISlot>(FIVE);
         this.FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_TheWorldTree);
         this.FOverlayerAppliance.Visible = false;
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FTempSelectInventoriesCount = new Vector.<uint>();
         this.FLogicDate = SLogicsCore.TheWorldTreeLogicData;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TUISlot = null;
         var _loc3_:int = 0;
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("TheWorldTree_GetReward") as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_CloseBtn = this.FThisPanel["MC_CloseBtn"];
         this.FTF_TreeLevel = this.FThisPanel["TF_TreeLevel"];
         this.FTF_WanOuNum = this.FThisPanel["TF_WanOuNum"];
         this.FTF_CanWuTime = this.FThisPanel["TF_CanWuTime"];
         this.FTF_BaseExp = this.FThisPanel["TF_BaseExp"];
         this.FTF_AllExp_Dec = this.FThisPanel["TF_AllExp_Dec"];
         this.FTF_TheWorldPower = this.FThisPanel["TF_TheWorldPower"];
         this.FMC_OnLineTime = this.FThisPanel["MC_OnLineTime"];
         _loc1_ = this.FMC_OnLineTime["MC_Icon"];
         _loc1_.gotoAndStop(3);
         this.FMC_HuiYeZhiLi = this.FThisPanel["MC_HuiYeZhiLi"];
         _loc1_ = this.FMC_HuiYeZhiLi["MC_Icon"];
         _loc1_.gotoAndStop(4);
         this.FMC_Vip = this.FThisPanel["MC_Vip"];
         _loc1_ = this.FMC_Vip["MC_Icon"];
         _loc1_.gotoAndStop(5);
         this.FMC_DaoJuDiaoLuo = this.FThisPanel["MC_DaoJuDiaoLuo"];
         _loc1_ = this.FMC_DaoJuDiaoLuo["MC_Icon"];
         _loc1_.gotoAndStop(1);
         this.FMC_JingYnaJaiCeng = this.FThisPanel["MC_JingYnaJaiCeng"];
         _loc1_ = this.FMC_JingYnaJaiCeng["MC_Icon"];
         _loc1_.gotoAndStop(2);
         this.FMC_SureBtn = this.FThisPanel["MC_SureBtn"];
         this.FMC_SlotArea = this.FThisPanel["MC_SlotArea"];
         this.FBTN_Left = this.FMC_SlotArea["BTN_Left"];
         this.FBTN_Right = this.FMC_SlotArea["BTN_Right"];
         _loc3_ = 0;
         while(_loc3_ < FIVE)
         {
            _loc2_ = this.GetUISlot();
            _loc2_.Resource = this.FMC_SlotArea["MC_Slot_" + _loc3_];
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.OnOverlay = this.SlotsOnOver;
            _loc2_.OnOut = this.SlotsOnOut;
            _loc2_.Init();
            this.FFiveSlot[_loc3_] = _loc2_;
            _loc3_++;
         }
         TGameUtil.setButtonMode(this.FMC_SureBtn,true);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         this.FDaoJuVec = this.FLogicDate.TheWorldTreeDropOutGoods;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_SureBtn.addEventListener(MouseEvent.CLICK,this.HandleClcik);
         this.FBTN_Left.addEventListener(MouseEvent.CLICK,this.HandleClcik);
         this.FBTN_Right.addEventListener(MouseEvent.CLICK,this.HandleClcik);
         this.FMC_CloseBtn.addEventListener(MouseEvent.CLICK,this.HandleClcik);
         super.ResourcesPerform_UILocations();
      }
      
      protected function HandleClcik(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_SureBtn:
               if(this.FSureBtnBackFun != null)
               {
                  this.FSureBtnBackFun();
               }
               break;
            case this.FMC_CloseBtn:
               this.visible = false;
               break;
            case this.FBTN_Left:
               --this.CurPageIndex;
               this.UpdatePage();
               break;
            case this.FBTN_Right:
               ++this.CurPageIndex;
               this.UpdatePage();
         }
      }
      
      public function OpenThisPanel() : void
      {
         this.CurPageIndex = 0;
         this.UpdateInventory();
         this.UpdatePage();
         this.UpdateProPerty();
      }
      
      protected function UpdateProPerty() : void
      {
         var _loc1_:UInt64 = new UInt64();
         this.FTF_TreeLevel.text = this.FLogicDate.ClearingObject["level"];
         this.FTF_CanWuTime.text = TGameUtil.fomatTime_NoDay(this.FLogicDate.ClearingObject["allTms"]);
         _loc1_.High = this.FLogicDate.ClearingObject["baseExp1"];
         _loc1_.Low = this.FLogicDate.ClearingObject["baseExp2"];
         this.FTF_BaseExp.text = _loc1_.ToString();
         _loc1_.High = this.FLogicDate.ClearingObject["allExp1"];
         _loc1_.Low = this.FLogicDate.ClearingObject["allExp2"];
         this.FTF_AllExp_Dec.text = _loc1_.ToString();
         this.FTF_TheWorldPower.text = this.FLogicDate.ClearingObject["treePower"];
         this.FMC_OnLineTime["TF_Time_Dec"].text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str11).DescribeString,TGameUtil.fomatTime_NoDay(this.FLogicDate.ClearingObject["onlineTms"]));
         _loc1_.High = this.FLogicDate.ClearingObject["onlineExp1"];
         _loc1_.Low = this.FLogicDate.ClearingObject["onlineExp2"];
         this.FMC_OnLineTime["TF_Exp_Dec"].text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str12).DescribeString,_loc1_.ToString());
         this.FMC_HuiYeZhiLi["TF_Time_Dec"].text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str11).DescribeString,TGameUtil.fomatTime_NoDay(this.FLogicDate.ClearingObject["dkTms"]));
         _loc1_.High = this.FLogicDate.ClearingObject["dkExp1"];
         _loc1_.Low = this.FLogicDate.ClearingObject["dkExp2"];
         this.FMC_HuiYeZhiLi["TF_Exp_Dec"].text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str12).DescribeString,_loc1_.ToString());
         this.FMC_Vip["TF_Time_Dec"].text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str11).DescribeString,TGameUtil.fomatTime_NoDay(this.FLogicDate.ClearingObject["vipTms"]));
         _loc1_.High = this.FLogicDate.ClearingObject["vipExp1"];
         _loc1_.Low = this.FLogicDate.ClearingObject["vipExp2"];
         this.FMC_Vip["TF_Exp_Dec"].text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str12).DescribeString,_loc1_.ToString());
         this.FMC_JingYnaJaiCeng["TF_Time_Dec"].text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str11).DescribeString,TGameUtil.fomatTime_NoDay(this.FLogicDate.ClearingObject["costTms"]));
         _loc1_.High = this.FLogicDate.ClearingObject["costExp1"];
         _loc1_.Low = this.FLogicDate.ClearingObject["costExp2"];
         this.FMC_JingYnaJaiCeng["TF_Exp_Dec"].text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str12).DescribeString,_loc1_.ToString());
         this.FMC_DaoJuDiaoLuo["TF_Time_Dec"].text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str11).DescribeString,TGameUtil.fomatTime_NoDay(this.FLogicDate.ClearingObject["dropTms"]));
         this.FMC_DaoJuDiaoLuo["TF_Exp_Dec"].text = "";
      }
      
      protected function UpdatePage() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         if(this.CurPageIndex <= 0)
         {
            _loc1_ = false;
            this.CurPageIndex = 0;
         }
         else
         {
            _loc1_ = true;
         }
         TGameUtil.setButtonMode(this.FBTN_Left,_loc1_);
         _loc2_ = this.FSelectInventories.Count / FIVE;
         if(this.CurPageIndex >= _loc2_)
         {
            _loc1_ = false;
            this.CurPageIndex = _loc2_;
         }
         else
         {
            _loc1_ = true;
         }
         TGameUtil.setButtonMode(this.FBTN_Right,_loc1_);
         this.UpdateFiveSlot();
      }
      
      protected function GetUISlot() : TUISlot
      {
         return new TUISlot(this);
      }
      
      protected function UpdateInventory() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         this.FTempSelectInventoriesId.length = 0;
         this.FTempSelectInventoriesCount.length = 0;
         this.FSelectInventories.Clear();
         var _loc5_:Vector.<uint> = new Vector.<uint>();
         _loc5_.length = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FDaoJuVec.length / 4)
         {
            _loc4_ = false;
            _loc2_ = 0;
            while(_loc2_ < _loc5_.length / 4)
            {
               if(this.FDaoJuVec[_loc1_ * 4 + 2] == _loc5_[_loc2_ * 4 + 2])
               {
                  _loc5_[_loc2_ * 4 + 3] += this.FDaoJuVec[_loc1_ * 4 + 3];
                  _loc4_ = true;
                  break;
               }
               _loc2_++;
            }
            if(!_loc4_)
            {
               _loc5_.push(this.FDaoJuVec[_loc1_ * 4 + 0]);
               _loc5_.push(this.FDaoJuVec[_loc1_ * 4 + 1]);
               _loc5_.push(this.FDaoJuVec[_loc1_ * 4 + 2]);
               _loc5_.push(this.FDaoJuVec[_loc1_ * 4 + 3]);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc5_.length / 4)
         {
            if(_loc5_[_loc1_ * 4 + 1] != 22)
            {
               this.FTempSelectInventoriesId.push(_loc5_[_loc1_ * 4 + 2]);
               this.FTempSelectInventoriesCount.push(_loc5_[_loc1_ * 4 + 3]);
            }
            else
            {
               _loc3_ += _loc5_[_loc1_ * 4 + 3];
            }
            _loc1_++;
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         _loc1_ = 0;
         while(_loc1_ < this.FSelectInventories.Count)
         {
            this.FSelectInventories.GetInventoryByIndex(_loc1_).Quantity = this.FTempSelectInventoriesCount[_loc1_];
            _loc1_++;
         }
         this.FTF_WanOuNum.text = _loc3_.toString();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(!this)
         {
            return;
         }
         if(!this.visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            this.FFiveSlot[_loc1_].Update();
            _loc1_++;
         }
         super.LogicsPerform();
      }
      
      protected function UpdateFiveSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            _loc2_ = this.CurPageIndex * FIVE + _loc1_;
            if(_loc2_ >= this.FSelectInventories.Count)
            {
               this.FFiveSlot[_loc1_].Context = null;
            }
            else
            {
               this.FFiveSlot[_loc1_].Context = this.FSelectInventories.GetInventoryByIndex(_loc2_);
            }
            _loc1_++;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      public function set SureBtnBackFun(param1:Function) : void
      {
         this.FSureBtnBackFun = param1;
      }
   }
}

