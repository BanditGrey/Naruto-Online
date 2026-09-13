package Processors.Game.Lobby.LostShenqi.Panel
{
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TLostsacredGenerate;
   import Logics.DatebaseVO.VO.TLostsacredUpgrade;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.LostShenQi.TLostShenQiLogicData;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Jade.TJadeCommon;
   import Processors.Game.Lobby.LostShenqi.TJieXiObject;
   import Processors.Game.Lobby.Talisman.TSingleEquip;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_LOSTSHENQI;
   import Resources.Strings.STRING_TALISMAN;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessoriShenQiUpgrade extends TProcessorLobbyWindow
   {
      
      public static const Two:int = 2;
      
      public static const Three:int = 3;
      
      public static const SIX:int = 6;
      
      public static const TEN:int = 10;
      
      protected var FThisPanel:MovieClip;
      
      protected var FIsInilization:Boolean;
      
      protected var FMC_ShengJiBtn:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_CurShuXing:TextField;
      
      protected var FTF_NextLevel:TextField;
      
      protected var FTF_NextShuXing:TextField;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FUITab:TUITab;
      
      protected var FRoleIndex:int;
      
      protected var FUIPageHeroList:TUIPage;
      
      protected var FPageIndexHeroList:int;
      
      protected var FCharacter:TCharacter;
      
      protected var FLostShenQiLogicData:TLostShenQiLogicData;
      
      protected var FCurShengJiSlot:TUISlot;
      
      protected var FCaiLiaoSlotVector:Vector.<TUISlot>;
      
      protected var FMC_SingleEquipList:Vector.<TSingleEquip>;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var TempInventories:TInventories;
      
      protected var IDTemplates:Vector.<uint>;
      
      protected var CurInventory:TInventory;
      
      protected var CurSingleEquip:TSingleEquip;
      
      protected var FInventoryVector:Vector.<TInventory>;
      
      protected var FMoreAttrite0:Vector.<TextField>;
      
      protected var FMoreAttrite1:Vector.<TextField>;
      
      protected var FMoreAttrite2:Vector.<TextField>;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FShengJiBackFunct:Function;
      
      protected var FCurHeroId:uint;
      
      protected var FPiaoZi:Function;
      
      public function TProcessoriShenQiUpgrade(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
         this.FUIPageHeroList = new TUIPage(this);
         this.FInventoryVector = new Vector.<TInventory>();
         this.FCaiLiaoSlotVector = new Vector.<TUISlot>(Two);
         this.FMC_SingleEquipList = new Vector.<TSingleEquip>();
         this.FMoreAttrite0 = new Vector.<TextField>(Three);
         this.FMoreAttrite1 = new Vector.<TextField>(Three);
         this.FMoreAttrite2 = new Vector.<TextField>(Three);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.IDTemplates = new Vector.<uint>();
         this.TempInventories = new TInventories();
         this.FCharacter = SLogicsCore.Character;
         this.FLostShenQiLogicData = SLogicsCore.LostShenQiLogicData;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      public function set SetPanel(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         this.IniLization();
      }
      
      protected function IniLization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TUISlot = null;
         this.FTF_Name = this.FThisPanel["TF_Name"];
         this.FTF_CurShuXing = this.FThisPanel["TF_CurShuXing"];
         this.FTF_NextLevel = this.FThisPanel["TF_NextLevel"];
         this.FTF_NextShuXing = this.FThisPanel["TF_NextShuXing"];
         _loc1_ = 0;
         while(_loc1_ < TEN)
         {
            _loc2_ = this.FThisPanel["MC_HeroLabel_" + _loc1_];
            this.FUITab.SetTabByIndex(_loc2_,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.RoleTabOnSwitch;
         this.FUITab.Init();
         _loc2_ = this.FThisPanel["MC_ChangeBtn"]["MC_PageLeft"];
         this.FUIPageHeroList.ButtonPrevious.Substrate = _loc2_;
         _loc2_ = this.FThisPanel["MC_ChangeBtn"]["MC_PageRight"];
         this.FUIPageHeroList.ButtonNext.Substrate = _loc2_;
         this.FUIPageHeroList.LabelPage = this.FThisPanel["MC_ChangeBtn"]["TF_Page"];
         this.FUIPageHeroList.PageSize = TEN;
         this.FUIPageHeroList.OnChangePage = this.HeroListPageOnChange;
         this.FUIPageHeroList.Init();
         this.FMC_ShengJiBtn = this.FThisPanel["MC_ShengJiBtn"];
         this.FCurShengJiSlot = new TUISlot(this);
         _loc2_ = this.FThisPanel["MC_CurShenQi"];
         this.FCurShengJiSlot.Resource = _loc2_;
         TJadeCommon.InitSlot(this.FCurShengJiSlot,CONST_MODULES.MODULE_LostShenQi);
         this.FCurShengJiSlot.OnClick = this.CurShengJiSlotOnClick;
         this.FCurShengJiSlot.Init();
         this.FCurShengJiSlot.OnOverlay = this.SlotsOnMove;
         this.FCurShengJiSlot.OnOut = this.SlotsOnOut;
         _loc1_ = 0;
         while(_loc1_ < SIX)
         {
            this.FMoreAttrite0[_loc1_] = this.FThisPanel["TF_Value" + _loc1_];
            this.FMoreAttrite1[_loc1_] = this.FThisPanel["TF_Value0" + _loc1_];
            this.FMoreAttrite2[_loc1_] = this.FThisPanel["TF_Value00" + _loc1_];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc3_ = new TUISlot(this);
            _loc2_ = this.FThisPanel["MC_CaiLiaoSlot_" + _loc1_];
            _loc2_["TF_NeedNum"].mouseEnabled = false;
            _loc3_.Resource = _loc2_;
            TJadeCommon.InitSlot(_loc3_,CONST_MODULES.MODULE_LostShenQi);
            _loc3_.Init();
            _loc3_.OnOverlay = this.SlotsOnMove;
            _loc3_.OnOut = this.SlotsOnOut;
            this.FCaiLiaoSlotVector[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc2_ = this.FThisPanel["mc_list"];
         this.FScrollBar = new TScrollBar(_loc2_,348,false,0);
         this.FIsInilization = true;
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         if(!this.FMC_ShengJiBtn.buttonMode)
         {
            return;
         }
         if(this.FShengJiBackFunct != null)
         {
            this.FShengJiBackFunct(this.CurInventory,this.FCurHeroId);
         }
      }
      
      protected function CurShengJiSlotOnClick(param1:Object, param2:Object) : void
      {
         this.Nimei();
         this.SlotsOnOut(param1,param2 as TInventory);
         this.UpdateView();
      }
      
      protected function Nimei() : void
      {
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = false;
            this.CurSingleEquip = null;
         }
         this.CurInventory = null;
      }
      
      protected function SingleEquipOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:uint = 0;
         var _loc5_:TLostsacredUpgrade = null;
         this.CurInventory = param2 as TInventory;
         this.CurSingleEquip = param1 as TSingleEquip;
         var _loc4_:String = "";
         _loc4_ = this.CurInventory.IDTemplate.toString() + (this.CurInventory.UpgradingLevel + 1);
         _loc3_ = uint(_loc4_);
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LostsacredUpgrade,_loc3_) as TLostsacredUpgrade;
         if(!_loc5_)
         {
            this.Nimei();
            if(this.FPiaoZi != null)
            {
               this.FPiaoZi(new ConsumeFrame(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_13).DescribeString);
            }
            this.FCurShengJiSlot.Context = null;
            this.UpdateView();
            return;
         }
         this.FCurShengJiSlot.Context = this.CurInventory;
         this.UpdateView();
      }
      
      public function RestDate() : void
      {
         this.Nimei();
         this.FCurShengJiSlot.Context = null;
         this.FCaiLiaoSlotVector[0].Context = null;
         this.FCaiLiaoSlotVector[0].SetNum(0,0,16777215,true);
         this.FCaiLiaoSlotVector[1].Context = null;
         this.FCaiLiaoSlotVector[1].SetNum(0,0,16777215,true);
         this.FCaiLiaoSlotVector[2].Context = null;
         this.FCaiLiaoSlotVector[2].SetNum(0,0,16777215,true);
         this.FTF_Name.text = "";
         this.FTF_CurShuXing.text = "";
         this.FTF_NextShuXing.text = "";
         this.FTF_NextLevel.text = "";
         var _loc1_:int = 0;
         while(_loc1_ < SIX)
         {
            this.FMoreAttrite0[_loc1_].text = "";
            this.FMoreAttrite1[_loc1_].text = "";
            this.FMoreAttrite2[_loc1_].text = "";
            _loc1_++;
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TEquipment = null;
         var _loc7_:TLostsacredUpgrade = null;
         var _loc8_:TLostsacredUpgrade = null;
         var _loc9_:uint = 0;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc12_:TJieXiObject = null;
         var _loc13_:Array = null;
         var _loc14_:String = null;
         var _loc15_:Array = null;
         _loc2_ = this.FMC_SingleEquipList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.FMC_SingleEquipList[_loc3_].BClick = false;
            _loc3_++;
         }
         if(!this.CurInventory || (this.CurInventory as TEquipment).UpgradingLevel >= 20)
         {
            this.CurInventory == null;
            this.RestDate();
            _loc1_ = false;
         }
         else
         {
            this.CurSingleEquip.BSelect = true;
            this.CurSingleEquip.SetEquip(this.CurInventory,this.CurInventory.Name,STRING_TALISMAN.STRINGS_TalismanUpgrade + this.CurInventory.UpgradingLevel,this.CurInventory.Quality,true);
            _loc6_ = this.CurInventory as TEquipment;
            this.FTF_Name.text = _loc6_.UpgradingLevel.toString();
            this.FTF_Name.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc6_.Quantity];
            _loc5_ = _loc6_.BasisProperty;
            this.FTF_CurShuXing.text = STRING_TALISMAN.STRINGS_TalismanProperty[this.CurInventory.CategorySecond - 7] + (_loc5_ + _loc6_.UpgradingBasisProperty);
            _loc10_ = "";
            _loc11_ = int(this.CurInventory.UpgradingLevel);
            _loc10_ = this.CurInventory.IDTemplate.toString() + _loc11_;
            _loc9_ = uint(_loc10_);
            _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LostsacredUpgrade,_loc9_) as TLostsacredUpgrade;
            _loc11_++;
            _loc10_ = this.CurInventory.IDTemplate.toString() + _loc11_;
            _loc9_ = uint(_loc10_);
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LostsacredUpgrade,_loc9_) as TLostsacredUpgrade;
            if(!_loc7_)
            {
               this.Nimei();
               this.UpdateView();
               return;
            }
            _loc4_ = _loc7_.AddValue;
            this.FTF_NextShuXing.text = STRING_TALISMAN.STRINGS_TalismanProperty[this.CurInventory.CategorySecond - 7] + (_loc5_ + _loc4_);
            this.FTF_NextLevel.text = _loc11_.toString();
            _loc10_ = this.CurInventory.IDTemplate.toString() + 0;
            _loc9_ = uint(_loc10_);
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LostsacredUpgrade,_loc9_) as TLostsacredUpgrade;
            _loc12_ = _loc7_.JieXiObject;
            if(_loc12_)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc12_.LevelVector.length)
               {
                  _loc13_ = _loc7_.AddextraValueArray[_loc3_];
                  _loc10_ = TUtilityString.Format(STRING_LOSTSHENQI.str1,_loc12_.LevelVector[_loc3_]);
                  this.FMoreAttrite0[_loc3_].text = _loc10_;
                  _loc11_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc12_.Value0Vector[_loc3_]);
                  _loc14_ = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc11_];
                  if(_loc12_.Value3Vector[_loc3_] == 1)
                  {
                     _loc10_ = TUtilityString.Format(STRING_LOSTSHENQI.str2,_loc14_,this.ChangeToRateString(_loc12_.Value1Vector[_loc3_],_loc12_.Value2Vector[_loc3_]));
                  }
                  else
                  {
                     _loc10_ = TUtilityString.Format(STRING_LOSTSHENQI.str2,_loc14_,_loc12_.Value1Vector[_loc3_]);
                  }
                  this.FMoreAttrite1[_loc3_].text = _loc10_;
                  if(this.CurInventory.UpgradingLevel >= _loc12_.LevelVector[_loc3_])
                  {
                     this.FMoreAttrite2[_loc3_].text = STRING_LOSTSHENQI.str4;
                     this.FMoreAttrite2[_loc3_].textColor = 6750003;
                  }
                  else
                  {
                     this.FMoreAttrite2[_loc3_].text = STRING_LOSTSHENQI.str5;
                     this.FMoreAttrite2[_loc3_].textColor = 16777215;
                  }
                  _loc3_++;
               }
            }
            else
            {
               _loc3_ = 0;
               while(_loc3_ < SIX)
               {
                  this.FMoreAttrite0[_loc3_].text = "";
                  this.FMoreAttrite1[_loc3_].text = "";
                  this.FMoreAttrite2[_loc3_].text = "";
                  _loc3_++;
               }
            }
            this.TempInventories.Clear();
            this.IDTemplates.length = 0;
            this.IDTemplates.push(this.FLostShenQiLogicData.ShenJiFuId);
            this.IDTemplates.push(this.FLostShenQiLogicData.LostJadeId);
            this.IDTemplates.push(this.FLostShenQiLogicData.ShenQiHeXinId);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.TempInventories,this.IDTemplates);
            _loc4_ = _loc8_.CostItemCount;
            _loc5_ = uint(this.getInventoryById(this.FLostShenQiLogicData.ShenJiFuId));
            _loc1_ = _loc5_ >= _loc4_ ? true : false;
            _loc11_ = _loc1_ ? 6750003 : 16711680;
            _loc3_ = 0;
            if(_loc1_)
            {
               _loc3_++;
            }
            this.FCaiLiaoSlotVector[0].Context = this.TempInventories.GetInventoryByIndex(0);
            this.FCaiLiaoSlotVector[0].SetNum(_loc4_,_loc5_,_loc11_);
            _loc4_ = _loc8_.CostlostItemCount;
            _loc5_ = this.FLostShenQiLogicData.LostJadeNum;
            _loc1_ = _loc5_ >= _loc4_ ? true : false;
            _loc11_ = _loc1_ ? 6750003 : 16711680;
            if(_loc1_)
            {
               _loc3_++;
            }
            _loc1_ = _loc3_ == 2 ? true : false;
            this.FCaiLiaoSlotVector[1].Context = this.TempInventories.GetInventoryByIndex(1);
            this.FCaiLiaoSlotVector[1].SetNum(_loc4_,_loc5_,_loc11_);
            _loc15_ = JSON.parse(_loc8_.Costsheart) as Array;
            if(_loc15_.length > 0)
            {
               _loc4_ = uint(_loc15_[1]);
               _loc5_ = uint(this.getInventoryById(_loc15_[0]));
               _loc11_ = _loc5_ >= _loc4_ ? 6750003 : 16711680;
               this.FCaiLiaoSlotVector[2].Context = this.TempInventories.GetInventoryByIndex(2);
               this.FCaiLiaoSlotVector[2].SetNum(_loc4_,_loc5_,_loc11_);
            }
            else
            {
               this.FCaiLiaoSlotVector[2].Context = null;
               this.FCaiLiaoSlotVector[2].SetNum(0,0,16777215,true);
            }
         }
         TGameUtil.setButtonMode(this.FMC_ShengJiBtn,_loc1_);
      }
      
      protected function getInventoryById(param1:uint) : int
      {
         var _loc2_:TInventories = SLogicsCore.Character.Appliances;
         return _loc2_.GetAllCountByTempletID(param1);
      }
      
      protected function ChangeToRateString(param1:uint, param2:uint) : String
      {
         if(param2 == 1000)
         {
            return param1 / 10 + "%";
         }
         return param1 + "%";
      }
      
      protected function RoleTabOnSwitch(param1:Object) : void
      {
         this.FRoleIndex = param1 as int;
         this.RestDate();
         this.FRoleIndex += this.FPageIndexHeroList * TEN;
         this.SligeEquipSetValue();
      }
      
      private function HeroListPageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndexHeroList = param2;
         this.UpdateRoleTab();
         this.FUITab.SwithTagManual(0);
         this.RoleTabOnSwitch(0);
      }
      
      public function OpenThisPanel() : void
      {
         this.RestDate();
         this.FPageIndexHeroList = 0;
         this.FRoleIndex = 0;
         this.SetupHeroListPage();
         this.UpdateRoleTab();
         this.FUITab.SwithTagManual(0);
         this.RoleTabOnSwitch(0);
         this.UpdateView();
      }
      
      public function SligeEquipSetValue(param1:Boolean = false) : void
      {
         var _loc2_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:TSingleEquip = null;
         var _loc5_:TInventory = null;
         var _loc6_:uint = 0;
         var _loc7_:THero = null;
         _loc3_ = this.FMC_SingleEquipList.length;
         _loc2_ = int(_loc3_ - 1);
         while(_loc2_ > -1)
         {
            _loc4_ = this.FMC_SingleEquipList[_loc2_];
            _loc4_.StubReferences.Dereference(this);
            _loc2_--;
         }
         this.FMC_SingleEquipList.length = 0;
         if(this.FRoleIndex >= this.FCharacter.Heros.Count)
         {
            _loc3_ = uint(this.FCharacter.Treasures.Count);
            this.FCurHeroId = 0;
         }
         else
         {
            _loc7_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
            _loc3_ = uint(_loc7_.TalismansMounted.Capacity);
            this.FCurHeroId = _loc7_.Identifier;
         }
         this.FScrollBar.Clear();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FRoleIndex >= this.FCharacter.Heros.Count)
            {
               _loc5_ = this.FCharacter.Treasures.GetInventoryByIndex(_loc2_);
            }
            else
            {
               _loc5_ = _loc7_.TalismansMounted.GetInventoryByIndex(_loc2_);
            }
            if(_loc5_ != null && this.GetBoo(_loc5_))
            {
               _loc4_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               _loc4_.StubReferences.Reference(this);
               _loc4_.OnClick = this.SingleEquipOnClick;
               _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
               _loc4_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
               _loc4_.OnOut = this.SlotsOnOut;
               _loc4_.OnOver = this.SlotsOnMove;
               this.FMC_SingleEquipList.push(_loc4_);
               _loc4_.SetEquip(_loc5_,_loc5_.Name,STRING_TALISMAN.STRINGS_TalismanUpgrade + _loc5_.UpgradingLevel,_loc5_.Quality);
               this.FScrollBar.AddItem(_loc4_);
               if(param1)
               {
                  if(this.CurInventory)
                  {
                     if(_loc5_.Identifier0 == this.CurInventory.Identifier0 && _loc5_.Identifier1 == this.CurInventory.Identifier1)
                     {
                        this.SingleEquipOnClick(_loc4_,_loc5_);
                     }
                  }
               }
               _loc6_++;
            }
            _loc2_++;
         }
         if(_loc6_ < CONST_TALISMAN.CAPACITY_EQUIP || _loc6_ == 0)
         {
            _loc3_ = CONST_TALISMAN.CAPACITY_EQUIP;
            _loc2_ = 0;
            while(_loc2_ < _loc3_ - _loc6_)
            {
               _loc4_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               this.FScrollBar.AddItem(_loc4_);
               _loc2_++;
            }
         }
         if(!param1)
         {
            this.FScrollBar.ScrollToUp();
         }
      }
      
      protected function GetBoo(param1:TInventory) : Boolean
      {
         var _loc2_:TLostsacredGenerate = null;
         _loc2_ = SLogicsCore.LostShenQiLogicData.LostsacredGenerateBins.GetDatebaseByValue("ArtifactId",param1.IDTemplate) as TLostsacredGenerate;
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function UiLocations() : void
      {
         this.FMC_ShengJiBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      public function LogicsUpdate() : void
      {
         var _loc1_:int = 0;
         if(!this.FIsInilization)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FMC_SingleEquipList.length)
         {
            this.FMC_SingleEquipList[_loc1_].UpdateSingleEquip();
            _loc1_++;
         }
         this.FCurShengJiSlot.Update();
         this.FCaiLiaoSlotVector[0].Update();
         this.FCaiLiaoSlotVector[1].Update();
         this.FCaiLiaoSlotVector[2].Update();
      }
      
      protected function UpdateRoleTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THero = null;
         var _loc3_:uint = 0;
         var _loc4_:THeros = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc4_ = this.FCharacter.Heros;
         _loc4_.Sort();
         _loc6_ = _loc4_.Count;
         _loc1_ = 0;
         while(_loc1_ < TEN)
         {
            _loc5_ = this.FPageIndexHeroList * TEN + _loc1_;
            if(_loc5_ < _loc6_)
            {
               _loc2_ = _loc4_.GetHeroByIndex(_loc5_);
               _loc3_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc2_.Quality];
               this.FUITab.SetTabShowByIndex(_loc1_);
               this.FUITab.SetTabCaptionByIndex(_loc2_.Name,_loc1_,_loc3_);
            }
            else if(_loc5_ == _loc6_)
            {
               this.FUITab.SetTabShowByIndex(_loc1_);
               this.FUITab.SetTabCaptionByIndex(STRING_COMMON.STRING_Backage,_loc1_,16775109);
            }
            else if(_loc5_ > _loc6_)
            {
               this.FUITab.SetTabHideByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function SetupHeroListPage() : void
      {
         this.FUIPageHeroList.TotalQuantity = this.FCharacter.Heros.Count;
         this.FUIPageHeroList.Update();
         this.FUIPageHeroList.PageIndex = this.FPageIndexHeroList;
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_LostShenQi);
         }
      }
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         _loc4_ = param2 as TInventory;
         if(_loc4_.UpgradingLevel > 0)
         {
            param3.Value = STRING_COMMON.FORMAT_Level + _loc4_.UpgradingLevel.toString();
         }
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function set ShengJiBackFunct(param1:Function) : void
      {
         this.FShengJiBackFunct = param1;
      }
      
      public function set PiaoZi(param1:Function) : void
      {
         this.FPiaoZi = param1;
      }
   }
}

