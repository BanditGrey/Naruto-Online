package Processors.Game.Lobby.TongLing
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TBB_BuyRapid;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TBB_Train;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TongLing.TTongLingData;
   import Logics.TongLing.TTongLingDatas;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TongLing.ToolS.FiveCell;
   import Processors.Game.Lobby.TongLing.ToolS.FourCell;
   import Processors.Game.Lobby.TongLing.ToolS.MouseIcon;
   import Processors.Game.Lobby.TongLing.ToolS.TProcessorBuyTuFeiShi;
   import Processors.Game.Lobby.TongLing.ToolS.TProcessorPathPic;
   import Processors.Game.Lobby.TongLing.ToolS.TProcessorPeiYangMode;
   import Processors.Game.Lobby.TongLing.ToolS.TProcessorShopJinHua;
   import Processors.Game.Lobby.TongLing.ToolS.TProcessorTuFeiPeiYang;
   import Processors.Game.Lobby.TongLing.ToolS.TongLingUint;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Editors.TUIWindowEditor;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.TongLingAnimal.LittleTip;
   import Rendering.Overlayers.TongLingAnimal.TongLingAttriteTip;
   import Rendering.Overlayers.TongLingAnimal.TongLingOtherMsg;
   import Rendering.Overlayers.TongLingAnimal.TongLingOtherMsgCopy;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_LOSTSHENQI;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TPressorWindowTongLing extends TProcessorLobbyWindows
   {
      
      public static const UINTCOUNT:int = 6;
      
      protected var ATT_Count:uint = 24;
      
      protected var TongLingAnimal:TPressorTongLingAnimal = null;
      
      protected var TongLingCulTivate:TPressorTongLingCultivate = null;
      
      protected var TongLingEvolve:TPressorTongLingEvolve = null;
      
      protected var TongLingBattle:TPressorTongLingBattle = null;
      
      protected var TongLingPractice:TPressorTongLingPractice = null;
      
      protected var TongLingDevour:TPressorTongLingDevour = null;
      
      protected var FMCPanelRoot:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FTabArr:Vector.<MovieClip>;
      
      protected var FMesArr:Array;
      
      protected var Vec_Down_Uints:Vector.<TongLingUint>;
      
      protected var FCurPage:int = 1;
      
      protected var FAllPage:int = 1;
      
      protected var FCurIndexUint:int = 1;
      
      protected var FAllPageUint:int = 1;
      
      protected var FAllCellCount:int;
      
      protected var FOpenCellCount:int = 0;
      
      protected var FCurIndexSelect:int = 0;
      
      protected var FAllIndexSelect:int = 0;
      
      protected var DragMouse:MouseIcon;
      
      protected var FDragVecs:Vector.<MovieClip>;
      
      protected var FIndexGobel:int = 77;
      
      protected var ShopJinHua:TProcessorShopJinHua;
      
      protected var ModePeiYang:TProcessorPeiYangMode;
      
      protected var JinHuaPath:TProcessorPathPic;
      
      protected var FProcessorTuFeiPeiYang:TProcessorTuFeiPeiYang = null;
      
      protected var FProcessorBuyTuFeiShi:TProcessorBuyTuFeiShi = null;
      
      protected var FUIWindowConfirmationSell:TUIWindowConfirmation;
      
      protected var FRoleLevel:int = 0;
      
      protected var FRoleVipLevel:int = 0;
      
      protected var FOpenedArrs:Array;
      
      protected var FTongLingArrs:Array;
      
      protected var TipShop:TongLingAttriteTip;
      
      protected var TipLittle:LittleTip;
      
      protected var FPopWindow:TUIWindowConfirmation;
      
      protected var FMcVecMoves:Vector.<MovieClip>;
      
      protected var FMousePicVisible:Boolean = false;
      
      protected var FAllIndex:int = 1;
      
      protected var AtrConditions:Vector.<Object>;
      
      protected var AttrJiaChengs:Vector.<Object>;
      
      protected var AnimalCellBuys:Vector.<Object>;
      
      protected var FSpeedTime:int;
      
      protected var FPropId:int;
      
      protected var FFosterOpens:Vector.<Object>;
      
      protected var CountLanZis:Vector.<Object>;
      
      protected var FTLZ_Scr:String;
      
      protected var FTLS_Scr:String;
      
      protected var FTL1:String;
      
      protected var FTL2:String;
      
      protected var FTL3:String;
      
      protected var FTL4:String;
      
      protected var FTL5:String;
      
      protected var FTL6:String;
      
      protected var FTongLingDatas:TTongLingDatas;
      
      protected var FEvolutionPoint:uint;
      
      protected var FIntiTongLingTempT:Array = new Array();
      
      protected var FIntiTongLingTempP:Array = new Array();
      
      protected var FFirstIn:Boolean;
      
      protected var FUpdataWindowHeroInfor:Function;
      
      protected var FOnCanGetAnimal:Function;
      
      protected var FPractice_Limit:uint;
      
      protected var FDevour_Limit:uint;
      
      protected var FHint:THint;
      
      protected var FMC_OneKeyTuFeiBtn:MovieClip = null;
      
      protected var FThisDate:TBB_BuyRapid = null;
      
      protected var FOpenShop:Function;
      
      protected var tbb:TBB_Status;
      
      protected var PeiYang_Obj:Object = null;
      
      protected var CurCostType:int;
      
      protected var NimeiObj:Object;
      
      protected var Nimeicout:int;
      
      protected var Nimeitype:int;
      
      protected var FOnUpdateLittlePetInfo:Function;
      
      protected var zhen:int = 0;
      
      protected var pei:int = 0;
      
      protected var FUpdateHeroPower:Function;
      
      public function TPressorWindowTongLing(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.JinHuaPath = new TProcessorPathPic(param1,FUICore);
         this.JinHuaPath.visible = false;
         this.ShopJinHua = new TProcessorShopJinHua(param1,FUICore);
         this.ShopJinHua.visible = false;
         this.ModePeiYang = new TProcessorPeiYangMode(param1,FUICore);
         this.ModePeiYang.visible = false;
         this.ModePeiYang.BackFunction = this.back_PeiYang;
         this.ModePeiYang.ExteShow = this.TraceMsg;
         this.TongLingAnimal = new TPressorTongLingAnimal(this,FUICore);
         this.TongLingAnimal.ExteShow = this.TraceMsg;
         this.TongLingCulTivate = new TPressorTongLingCultivate(this,FUICore);
         this.TongLingCulTivate.ExteShow = this.TraceMsg;
         this.TongLingCulTivate.SpeedFunction = this.speed;
         this.TongLingCulTivate.OneKeySpeedFunction = this.OneKeySpeed;
         this.TongLingEvolve = new TPressorTongLingEvolve(this,this.ShopJinHua,this.JinHuaPath,FUICore);
         this.TongLingEvolve.ExteShow = this.TraceMsg;
         this.TongLingEvolve.OpenShop = this.FOpenShopCopy;
         this.TongLingBattle = new TPressorTongLingBattle(this,FUICore);
         this.TongLingBattle.OnShowHtmlTip = ProcessorOnShowHtmlText;
         this.TongLingBattle.OnHideHtmlTip = ProcessorOnHideHtmlText;
         this.TongLingPractice = new TPressorTongLingPractice(this);
         this.TongLingPractice.OnGotoDevour = this.ProcessorGotoDevour;
         this.TongLingDevour = new TPressorTongLingDevour(this);
         this.TongLingDevour.OnGotoPractice = this.ProcessorGotoPractice;
         this.TongLingDevour.OnUint_Move = this.Uint_Move;
         this.TongLingDevour.OnUint_Out = this.Uint_Out;
         this.TongLingDevour.OnUint_Over = this.Uint_Over;
         this.TongLingDevour.ExteShow = this.TraceMsg;
         this.FProcessorTuFeiPeiYang = new TProcessorTuFeiPeiYang(param1);
         this.FProcessorTuFeiPeiYang.BackFun = this.TuFeiPeiYangBackFun;
         this.FProcessorTuFeiPeiYang.BuyTuFei = this.BuyTuFeiC_S;
         this.FProcessorTuFeiPeiYang.C_SFunc = this.TuFeiPeiYangC_S;
         this.FProcessorTuFeiPeiYang.Back_Out = this.Uint_Out;
         this.FProcessorTuFeiPeiYang.Back_Over = this.Uint_Over;
         this.FProcessorTuFeiPeiYang.Back_Move = this.Uint_Move;
         this.FProcessorBuyTuFeiShi = new TProcessorBuyTuFeiShi(param1);
         this.FProcessorBuyTuFeiShi.BuyBackFun = this.BuyBackFun;
         this.FProcessorBuyTuFeiShi.BackCloseFun = this.BackCloseFun;
         this.FMesArr = SLogicsCore.TongLingData;
         this.FTabArr = new Vector.<MovieClip>();
         this.Vec_Down_Uints = new Vector.<TongLingUint>();
         this.FDragVecs = new Vector.<MovieClip>();
         this.FOpenedArrs = SLogicsCore.TongLingOpened;
         this.FTongLingArrs = new Array();
         this.FMcVecMoves = new Vector.<MovieClip>();
         this.FIntiTongLingTempT = new Array();
         this.FIntiTongLingTempP = new Array();
         this.FTongLingDatas = SLogicsCore.TongLingDatas;
         this.FFirstIn = true;
         this.FUIWindowConfirmationSell = new TUIWindowConfirmation(param1.Parent);
         this.FUIWindowConfirmationSell.OnOK = this.WindowConfirmationSellOnOK;
         this.FUIWindowConfirmationSell.x = (FUICore.StageWidth - this.FUIWindowConfirmationSell.WindowWidth) / 2;
         this.FUIWindowConfirmationSell.y = (FUICore.StageHeight - this.FUIWindowConfirmationSell.WindowHeight) / 2;
         this.FUIWindowConfirmationSell.visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_TongLing);
      }
      
      protected function FOpenShopCopy() : void
      {
         this.FOpenShop();
      }
      
      public function set OpenShop(param1:Function) : void
      {
         this.FOpenShop = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc5_:MovieClip = null;
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.ShopJinHua.Load();
            this.JinHuaPath.Load();
            this.ModePeiYang.Load();
            this.FProcessorTuFeiPeiYang.Load();
            this.FProcessorBuyTuFeiShi.Load();
            return;
         }
         this.PacketPerform_CS_TongLingReq();
         var _loc2_:THeros = SLogicsCore.Character.Heros;
         var _loc3_:THero = _loc2_.GetHeroByIndex(0);
         this.FRoleLevel = int(_loc3_.Level);
         this.FRoleVipLevel = SLogicsCore.Character.VipLevel;
         if(this.FAllIndexSelect == 1 || this.FAllIndexSelect == 3)
         {
            this.setPerTure(this.FCurIndexSelect);
         }
         this.TongLingEvolve.OpenMe();
         MovieClip(this.FMCPanelRoot["MC_Left"]).gotoAndPlay(1);
         MovieClip(this.FMCPanelRoot["MC_Right"]).gotoAndPlay(1);
         var _loc4_:int = 0;
         while(_loc4_ < this.FMcVecMoves.length)
         {
            this.FMcVecMoves[_loc4_].gotoAndPlay(1);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < this.Vec_Down_Uints.length)
         {
            _loc5_ = this.Vec_Down_Uints[_loc4_].Apeture;
            _loc5_.gotoAndPlay(1);
            _loc4_++;
         }
         this.SetJnHuCount(this.FEvolutionPoint);
         if(this.FFirstIn)
         {
            this.FFirstIn = false;
            this.PaiXu();
            this.setPerTure(this.FCurIndexSelect);
            this.valuation();
            this.setBtnLR(this.FAllCellCount);
            this.addPetToCellT(this.FIntiTongLingTempT);
            this.addPetToCellP(this.FIntiTongLingTempP);
         }
         this.heihaya();
         this.yahahei();
         this.UpdateAttUI();
         if(SLogicsCore.Character.MainHero.Level >= this.FPractice_Limit)
         {
            this.FUITab.GetTabByIndex(4).gotoAndStop(TUITab.RENDERINGSTATE_UnSelect);
         }
         if(SLogicsCore.Character.MainHero.Level >= this.FDevour_Limit)
         {
            this.FUITab.GetTabByIndex(5).gotoAndStop(TUITab.RENDERINGSTATE_UnSelect);
         }
         this.UpdateOneKeyTuFeiBtn();
         this.ShowPanelByType(1);
      }
      
      public function PacketPerform_CS_TongLingReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingAnimal_Rep);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorGotoDevour(param1:Object) : void
      {
         this.FUITab.TabIndex = 5;
         this.TabOnSwitch(5);
      }
      
      protected function ProcessorGotoPractice(param1:Object) : void
      {
         this.FUITab.TabIndex = 4;
         this.TabOnSwitch(4);
      }
      
      override public function Unmount() : void
      {
         var _loc2_:MovieClip = null;
         super.Unmount();
         this.TongLingEvolve.CloseMe();
         var _loc1_:int = 0;
         while(_loc1_ < this.FMcVecMoves.length)
         {
            this.FMcVecMoves[_loc1_].gotoAndStop(1);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.Vec_Down_Uints.length)
         {
            _loc2_ = this.Vec_Down_Uints[_loc1_].Apeture;
            _loc2_.gotoAndStop(1);
            _loc1_++;
         }
         if(this.TongLingEvolve)
         {
            this.TongLingEvolve.ResetSlot();
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TONGLINGANIMAL.TONGLING_ID);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMCPanelRoot = TUtilityReflection.CreateDisplayObjectInstance(CONST_TONGLINGANIMAL.TONGLING_ROOT) as MovieClip;
         addChild(this.FMCPanelRoot);
         this.FMCPanelRoot.x = FUICore.StageWidth - this.FMCPanelRoot.width >> 1;
         this.FMCPanelRoot.y = FUICore.StageHeight - this.FMCPanelRoot.height >> 1;
         this.FTabArr.push(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_00],this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_01],this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_02],this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_03],this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_04],this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_05]);
         this.GetBaseCondition();
         this.TongLingAnimal.SetRoot(MovieClip(this.FTabArr[1]));
         this.TongLingCulTivate.setRoot(MovieClip(this.FTabArr[2]),this.FFosterOpens,this.FSpeedTime);
         this.TongLingEvolve.setMovi(MovieClip(this.FTabArr[3]));
         this.TongLingBattle.seRoot(MovieClip(this.FTabArr[0]));
         this.TongLingPractice.seRoot(MovieClip(this.FTabArr[4]));
         this.TongLingDevour.seRoot(MovieClip(this.FTabArr[5]));
         this.TongLingDevour.Reset();
         this.FMcVecMoves.length = 0;
         this.FMcVecMoves.push(this.FTabArr[1]["Pic"]["m_zhuan"]);
         this.FMcVecMoves.push(this.FTabArr[1]["Pic"]["m_zhuan"]["MC_FloatEffect"]);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.FMcVecMoves.push(this.FTabArr[0]["rabbit" + _loc1_]["m_zhuan"]);
            _loc1_++;
         }
         this.FMcVecMoves.push(this.FTabArr[0]["mc_zhuan"]);
         this.FMcVecMoves.push(this.FTabArr[4]["Pic"]["m_zhuan"]);
         this.FMcVecMoves.push(this.FTabArr[4]["Pic"]["m_zhuan"]["MC_FloatEffect"]);
         TextField(this.FTabArr[2]["t_animal_scr"]).text = this.FTLS_Scr;
         TextField(this.FTabArr[0]["zhenscr"]).text = this.FTLZ_Scr;
         this.FPopWindow = new TUIWindowConfirmation(this);
         this.FPopWindow.OnOK = this.PopWindowOnOk;
         this.FPopWindow.x = CONST_COMMON.STAGE_Width - this.FPopWindow.WindowWidth >> 1;
         this.FPopWindow.y = CONST_COMMON.STAGE_Height - this.FPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindow);
         this.FPopWindow.visible = false;
         this.Initilization();
         this.addEvent();
         this.Tab_Manager();
         this.DragMouse = new MouseIcon();
         this.addChild(this.DragMouse);
         this.DragMouse.mouseEnabled = false;
         this.DragMouse.visible = false;
         new Tools_Help(this,this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_HELP],CONST_SYSTEMLANGUAGE.TongLingAnimal,FUICore);
         this.TipShop = new TongLingAttriteTip(this);
         this.TipShop.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.TipShop);
         this.TipLittle = new LittleTip(this);
         this.TipLittle.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.TipLittle);
         this.FAllIndex = 0;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationSell);
         super.ResourcesPerform_UIDispatch();
      }
      
      public function PopWindowOnOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingBag_Rep);
         _loc3_ = _loc2_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function getUint(param1:int) : String
      {
         var _loc2_:String = STRING_INHERITPRACTICE.INHERIT_GOLD;
         switch(param1)
         {
            case 0:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_SILVER_COIN;
               break;
            case 2:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
               break;
            case 3:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLDORGIFT;
         }
         return _loc2_;
      }
      
      public function Uint_Out(param1:Object, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(param3)
         {
            if(param1.bai == 100)
            {
               if(param1.lock == 0)
               {
                  this.TipLittle.Hide();
               }
            }
            else
            {
               this.TipShop.Hide();
               if(param2)
               {
                  this.Vec_Down_Uints[param1.num].IconHighLight = false;
               }
            }
         }
         else
         {
            this.TipShop.Hide();
         }
      }
      
      public function Uint_Over(param1:Object, param2:Boolean = true, param3:Boolean = true) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         if(param3)
         {
            if(param1.bai == 100)
            {
               if(param1.lock == 0)
               {
                  _loc4_ = param1.num + (this.FCurIndexUint - 1) * UINTCOUNT;
                  this.TipLittle.Context = _loc4_;
                  this.TipLittle.Render(FUICore.MouseCoordinate);
                  this.TipLittle.Show();
               }
            }
            else
            {
               _loc5_ = {
                  "id":this.FMesArr[param1.num + (this.FCurPage - 1) * UINTCOUNT].Id,
                  "index":2,
                  "level":this.FMesArr[param1.num + (this.FCurPage - 1) * UINTCOUNT].Level,
                  "Identifier0":this.FMesArr[param1.num + (this.FCurPage - 1) * UINTCOUNT].Identifier0,
                  "Identifier1":this.FMesArr[param1.num + (this.FCurPage - 1) * UINTCOUNT].Identifier1
               };
               this.TipShop.Context = _loc5_;
               this.TipShop.Render(FUICore.MouseCoordinate);
               this.TipShop.Show();
               if(param2)
               {
                  this.Vec_Down_Uints[param1.num].IconHighLight = true;
               }
            }
         }
         else
         {
            _loc6_ = {
               "id":param1.Id,
               "index":2,
               "level":param1.Level,
               "Identifier0":param1.Identifier0,
               "Identifier1":param1.Identifier1
            };
            this.TipShop.Context = _loc6_;
            this.TipShop.Render(FUICore.MouseCoordinate);
            this.TipShop.Show();
         }
      }
      
      public function Uint_Move(param1:Object, param2:Boolean = true) : void
      {
         var _loc3_:Object = null;
         if(param2)
         {
            if(param1.bai == 100)
            {
               if(param1.lock == 0)
               {
                  this.TipLittle.Render(FUICore.MouseCoordinate);
               }
            }
            else if(param1.self == 1)
            {
               _loc3_ = {
                  "id":param1.Id,
                  "index":2,
                  "level":param1.Level,
                  "Identifier0":param1.Identifier0,
                  "Identifier1":param1.Identifier1
               };
               this.TipShop.Context = _loc3_;
               this.TipShop.Render(FUICore.MouseCoordinate);
               this.TipShop.Show();
            }
            else
            {
               this.TipShop.Render(FUICore.MouseCoordinate);
            }
         }
         else
         {
            this.TipShop.Render(FUICore.MouseCoordinate);
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FAllCellCount = this.AnimalCellBuys.length;
         this.tabVisible(this.FAllIndexSelect);
         this.TongLingEvolve.InitiaEditor(this.Parent);
         this.TongLingEvolve.FUIWindowEditor = new TUIWindowEditor(this.Parent,CONST_MODULES.MODULE_TongLing);
         this.TongLingEvolve.FUIWindowEditor.OnOK = this.TongLingEvolve.WindowEditorOnOK;
         this.TongLingEvolve.FUIWindowEditor.OnCancel = this.TongLingEvolve.WindowEditorOnCancel;
         this.TongLingEvolve.FUIWindowEditor.OnMax = this.TongLingEvolve.WindowEditorOnMax;
         this.TongLingEvolve.FUIWindowEditor.x = (CONST_COMMON.STAGE_Width - this.TongLingEvolve.FUIWindowEditor.WindowWidth) / 2;
         this.TongLingEvolve.FUIWindowEditor.y = (CONST_COMMON.STAGE_Height - this.TongLingEvolve.FUIWindowEditor.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowEditor(this.TongLingEvolve.FUIWindowEditor);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc2_:int = 0;
         var _loc3_:FourCell = null;
         var _loc4_:int = 0;
         var _loc5_:FiveCell = null;
         if(this.TongLingEvolve.FUIWindowEditor != null && this.TongLingEvolve.FUIWindowEditor.visible)
         {
            this.TongLingEvolve.FUIWindowEditor.Update();
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.FMesArr.length)
         {
            if(_loc1_ <= 5 && this.Vec_Down_Uints.length != 0)
            {
               if(this.Vec_Down_Uints[_loc1_].Content != null)
               {
                  this.Vec_Down_Uints[_loc1_].Update();
               }
            }
            _loc1_++;
         }
         if(this.TongLingCulTivate != null)
         {
            _loc2_ = this.TongLingCulTivate.getFourCellLength;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.TongLingCulTivate.GetFourCellByIndex(_loc1_);
               if(_loc3_ != null)
               {
                  _loc3_.UpdatePic();
               }
               _loc1_++;
            }
         }
         if(this.TongLingBattle != null)
         {
            _loc4_ = this.TongLingBattle.getFiveCellLength();
            _loc1_ = 0;
            while(_loc1_ < _loc4_)
            {
               _loc5_ = this.TongLingBattle.getFiveCellByIndex(_loc1_);
               if(_loc5_ != null)
               {
                  _loc5_.Update();
               }
               _loc1_++;
            }
         }
         if(this.FAllIndexSelect == 4)
         {
            this.TongLingPractice.UpdatePet();
         }
         if(this.FAllIndexSelect == 5)
         {
            this.TongLingDevour.UpdatePet();
         }
         if(this.TongLingAnimal != null)
         {
            this.TongLingAnimal.Updatet();
         }
         this.MouseUpdate();
         if(TPressorTongLingEvolve.ISUPDATE)
         {
            this.TongLingEvolve.update();
            this.TongLingEvolve.updatePic();
            this.ShopJinHua.Updates();
         }
         if(TProcessorPathPic.ISUPDATE)
         {
            this.JinHuaPath.Updates();
         }
         this.ModePeiYang.UpdateP();
         this.FProcessorTuFeiPeiYang.UpdatePanelImage();
         super.LogicsPerform();
      }
      
      protected function Initilization() : void
      {
         var _loc2_:TongLingUint = null;
         var _loc1_:int = 0;
         while(_loc1_ < UINTCOUNT)
         {
            _loc2_ = new TongLingUint(MovieClip(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_MC_Slot_ + _loc1_]));
            this.Vec_Down_Uints[_loc1_] = _loc2_;
            this.Vec_Down_Uints[_loc1_].Back_Click = this.Uint_Click;
            this.Vec_Down_Uints[_loc1_].Back_Down = this.Uint_Down;
            this.Vec_Down_Uints[_loc1_].Back_Up = this.Uint_Up;
            this.Vec_Down_Uints[_loc1_].Back_Out = this.Uint_Out;
            this.Vec_Down_Uints[_loc1_].Back_Over = this.Uint_Over;
            this.Vec_Down_Uints[_loc1_].Back_Move = this.Uint_Move;
            this.Vec_Down_Uints[_loc1_].OnBoxClick = this.extendSend;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this.FDragVecs.push(this.FMCPanelRoot["MC_00"]["rabbit" + _loc1_]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            this.FDragVecs.push(this.FMCPanelRoot["MC_02"]["train" + _loc1_]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            this.FDragVecs.push(this.FMCPanelRoot["MC_05"]["MC_Slot_" + _loc1_]);
            _loc1_++;
         }
         this.FMC_OneKeyTuFeiBtn = this.FMCPanelRoot["MC_02"]["MC_OneKeyTuFeiBtn"];
         TGameUtil.setButtonMode(this.FMC_OneKeyTuFeiBtn,true);
      }
      
      protected function addEvent() : void
      {
         var _loc1_:int = 0;
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.UpEvent);
         SimpleButton(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_CLOSE]).addEventListener(MouseEvent.CLICK,this.closeBtn);
         MovieClip(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_BTN_LEFT]).addEventListener(MouseEvent.CLICK,this.closeBtn);
         MovieClip(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_BTN_RIGHT]).addEventListener(MouseEvent.CLICK,this.closeBtn);
         MovieClip(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_EXTEND_BTN]).addEventListener(MouseEvent.CLICK,this.closeBtn);
         this.FMC_OneKeyTuFeiBtn.addEventListener(MouseEvent.CLICK,this.closeBtn);
         TGameUtil.setButtonMode(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_BTN_LEFT],true);
         TGameUtil.setButtonMode(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_BTN_RIGHT],true);
         TGameUtil.setButtonMode(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_EXTEND_BTN],true);
         while(_loc1_ < this.FDragVecs.length)
         {
            this.FDragVecs[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.DragMove);
            this.FDragVecs[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.DragOut);
            _loc1_++;
         }
      }
      
      public function DragMove(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMCPanelRoot["MC_00"]["rabbit0"]:
               this.FIndexGobel = 1;
               break;
            case this.FMCPanelRoot["MC_00"]["rabbit1"]:
               this.FIndexGobel = 2;
               break;
            case this.FMCPanelRoot["MC_00"]["rabbit2"]:
               this.FIndexGobel = 3;
               break;
            case this.FMCPanelRoot["MC_00"]["rabbit3"]:
               this.FIndexGobel = 4;
               break;
            case this.FMCPanelRoot["MC_00"]["rabbit4"]:
               this.FIndexGobel = 5;
               break;
            case this.FMCPanelRoot["MC_02"]["train0"]:
               this.FIndexGobel = 6;
               break;
            case this.FMCPanelRoot["MC_02"]["train1"]:
               this.FIndexGobel = 7;
               break;
            case this.FMCPanelRoot["MC_02"]["train2"]:
               this.FIndexGobel = 8;
               break;
            case this.FMCPanelRoot["MC_02"]["train3"]:
               this.FIndexGobel = 9;
               break;
            case this.FMCPanelRoot["MC_05"]["MC_Slot_0"]:
               this.FIndexGobel = 10;
               break;
            case this.FMCPanelRoot["MC_05"]["MC_Slot_1"]:
               this.FIndexGobel = 11;
         }
         this.DragMouse.filters = [new GlowFilter(3394560,1,5,5,20)];
      }
      
      public function DragOut(param1:MouseEvent) : void
      {
         this.FIndexGobel = 77;
         this.DragMouse.filters = [];
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         switch(_loc2_)
         {
            case 0:
               this.TabIsVisible(0);
               this.setPerTure(100);
               TPressorTongLingEvolve.ISUPDATE = 0;
               break;
            case 1:
               this.FCurIndexSelect = 0;
               this.TabIsVisible(1);
               this.setPerTure(this.FCurIndexSelect);
               this.valuation();
               TPressorTongLingEvolve.ISUPDATE = 0;
               break;
            case 2:
               this.TabIsVisible(2);
               this.setPerTure(100);
               TPressorTongLingEvolve.ISUPDATE = 0;
               break;
            case 3:
               this.FCurIndexSelect = 0;
               this.TabIsVisible(3);
               this.setPerTure(this.FCurIndexSelect);
               this.valuation();
               TPressorTongLingEvolve.ISUPDATE = 1;
               break;
            case 4:
               this.FCurIndexSelect = 0;
               this.TabIsVisible(4);
               this.setPerTure(this.FCurIndexSelect);
               TPressorTongLingEvolve.ISUPDATE = 0;
               break;
            case 5:
               this.FCurIndexSelect = 0;
               this.TabIsVisible(5);
               this.setPerTure(this.FCurIndexSelect);
               TPressorTongLingEvolve.ISUPDATE = 0;
         }
      }
      
      protected function TabIsVisible(param1:int) : void
      {
         this.tabVisible(param1);
         this.FAllIndexSelect = param1;
      }
      
      protected function Tab_Manager() : void
      {
         this.FUITab = new TUITab(this);
         this.FUITab.SetTabByIndex(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_TAB0],0);
         this.FUITab.SetTabByIndex(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_TAB1],1);
         this.FUITab.SetTabByIndex(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_TAB2],2);
         this.FUITab.SetTabByIndex(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_TAB3],3);
         this.FUITab.SetTabByIndex(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_TAB4],4);
         this.FUITab.SetTabByIndex(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_TAB5],5);
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FUITab.SetTabEnabledByIndex(4,false);
         this.FUITab.SetTabEnabledByIndex(5,false);
         this.FUITab.OnOver = this.UITabOnOver;
         this.FUITab.OnOut = this.UITabOnOut;
         this.FHint = new THint();
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         if(!SLogicsCore.Character.GetConfigValueById(91000008))
         {
            this.FUITab.SetTabHideByIndex(4);
            this.FUITab.SetTabHideByIndex(5);
         }
      }
      
      protected function UITabOnOver(param1:Object, param2:uint, param3:Boolean) : void
      {
         var _loc4_:TUITab = null;
         var _loc5_:MovieClip = null;
         if(!param3 && param2 == 4)
         {
            _loc4_ = param1 as TUITab;
            _loc5_ = _loc4_.GetTabByIndex(param2);
            if(_loc5_.currentFrame != TUITab.RENDERINGSTATE_Disabled)
            {
               return;
            }
            this.FHint.Caption = TUtilityString.Format(STRING_TONGLING.TONGLING_74,this.FPractice_Limit);
            ProcessorTipOnOver(this,this.FHint);
         }
         if(!param3 && param2 == 5)
         {
            _loc4_ = param1 as TUITab;
            _loc5_ = _loc4_.GetTabByIndex(param2);
            if(_loc5_.currentFrame != TUITab.RENDERINGSTATE_Disabled)
            {
               return;
            }
            this.FHint.Caption = TUtilityString.Format(STRING_TONGLING.TONGLING_75,this.FDevour_Limit);
            ProcessorTipOnOver(this,this.FHint);
         }
      }
      
      protected function UITabOnOut(param1:Object, param2:uint, param3:Boolean) : void
      {
         if(!param3 && (param2 == 4 || param2 == 5))
         {
            ProcessorTipOnOut(this);
         }
      }
      
      protected function tabVisible(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.FTabArr.length)
         {
            MovieClip(this.FTabArr[_loc2_]).visible = false;
            _loc2_++;
         }
         MovieClip(this.FTabArr[param1]).visible = true;
         switch(param1)
         {
            case 0:
               TextField(this.FMCPanelRoot["TX_gold"]).text = this.FTL1;
               break;
            case 1:
               TextField(this.FMCPanelRoot["TX_gold"]).text = this.FTL2;
               break;
            case 2:
               TextField(this.FMCPanelRoot["TX_gold"]).text = this.FTL3;
               break;
            case 3:
               TextField(this.FMCPanelRoot["TX_gold"]).text = this.FTL4;
               break;
            case 4:
               TextField(this.FMCPanelRoot["TX_gold"]).text = this.FTL5;
               break;
            case 5:
               TextField(this.FMCPanelRoot["TX_gold"]).text = this.FTL6;
         }
      }
      
      public function closeBtn(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_CLOSE]:
               ProcessorClose();
               break;
            case this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_BTN_LEFT]:
               if(this.FCurPage > 1)
               {
                  --this.FCurPage;
               }
               if(this.FCurIndexUint > 1)
               {
                  --this.FCurIndexUint;
               }
               this.setBtnLR(this.FAllCellCount);
               this.valuation();
               break;
            case this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_BTN_RIGHT]:
               if(this.FCurPage < this.FAllPage)
               {
                  ++this.FCurPage;
               }
               if(this.FCurIndexUint < this.FAllPageUint)
               {
                  ++this.FCurIndexUint;
               }
               this.setBtnLR(this.FAllCellCount);
               this.valuation();
               break;
            case this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_EXTEND_BTN]:
               this.extendSend();
               break;
            case this.FMC_OneKeyTuFeiBtn:
               if(param1.currentTarget.buttonMode)
               {
                  this.ShowPanelByType(0);
               }
         }
      }
      
      protected function ShowPanelByType(param1:int) : void
      {
         this.FProcessorTuFeiPeiYang.visible = false;
         this.FMCPanelRoot.visible = false;
         this.FProcessorBuyTuFeiShi.visible = false;
         switch(param1)
         {
            case 0:
               this.FProcessorTuFeiPeiYang.visible = true;
               this.FProcessorTuFeiPeiYang.OpenThisPanel();
               break;
            case 1:
               this.FMCPanelRoot.visible = true;
               break;
            case 2:
               this.FProcessorTuFeiPeiYang.visible = true;
               this.FProcessorBuyTuFeiShi.visible = true;
         }
      }
      
      protected function TuFeiPeiYangBackFun() : void
      {
         this.ShowPanelByType(1);
      }
      
      protected function setBtnLR(param1:int) : void
      {
         this.FAllPageUint = Math.ceil(param1 / UINTCOUNT);
         TextField(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_PAGE]).text = this.FOpenCellCount + "/" + param1;
         if(this.FAllPageUint <= 1)
         {
            TGameUtil.setButtonMode(MovieClip(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_BTN_LEFT]),false);
            TGameUtil.setButtonMode(MovieClip(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_BTN_RIGHT]),false);
         }
         else
         {
            TGameUtil.setButtonMode(MovieClip(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_BTN_LEFT]),this.FCurIndexUint == 1 ? false : true);
            TGameUtil.setButtonMode(MovieClip(this.FMCPanelRoot[CONST_TONGLINGANIMAL.TONGLING_BTN_RIGHT]),this.FCurIndexUint >= this.FAllPageUint ? false : true);
         }
         if(this.FAllPageUint < this.FCurIndexUint)
         {
            this.FAllPageUint = this.FCurIndexUint;
         }
      }
      
      public function Uint_Click(param1:Object) : void
      {
         if(param1.bai == 100)
         {
            return;
         }
         this.FCurIndexSelect = param1.num;
         if(this.FAllIndexSelect == 1)
         {
            this.setPerTure(param1.num);
         }
         else if(this.FAllIndexSelect == 3)
         {
            this.setPerTure(param1.num);
         }
         else if(this.FAllIndexSelect == 4)
         {
            this.setPerTure(param1.num);
         }
      }
      
      public function Uint_Down(param1:Object) : void
      {
         if(param1.bai == 100)
         {
            return;
         }
         this.FCurIndexSelect = param1.num;
         this.tbb = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,Object(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT]).Id) as TBB_Status;
         if(this.FAllIndexSelect == 0)
         {
            if(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT].isCanMove2 == 0)
            {
               this.DragMouse.SetPicId = this.tbb.SmPic;
               this.DragMouse.visible = true;
               this.FMousePicVisible = true;
               this.DragMouse.IsRun = true;
            }
         }
         else if(this.FAllIndexSelect == 2)
         {
            if(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT].isCanMove == 0)
            {
               if(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT].isCanEvolve == 1)
               {
                  EffectGenerateText(STRING_TONGLING.TONGLING_o);
                  return;
               }
               this.DragMouse.SetPicId = this.tbb.SmPic;
               this.DragMouse.visible = true;
               this.FMousePicVisible = true;
               this.DragMouse.IsRun = true;
            }
         }
         else if(this.FAllIndexSelect == 5)
         {
            if(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT].isPeiYang != 0)
            {
               EffectGenerateText(STRING_TONGLING.TONGLING_65);
               return;
            }
            if(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT].isCanMove2 != 0)
            {
               EffectGenerateText(STRING_TONGLING.TONGLING_66);
               return;
            }
            this.DragMouse.SetPicId = this.tbb.SmPic;
            this.DragMouse.visible = true;
            this.FMousePicVisible = true;
            this.DragMouse.IsRun = true;
         }
      }
      
      public function Uint_Up(param1:int) : void
      {
         if(this.FAllIndexSelect == 0 || this.FAllIndexSelect == 2 || this.FAllIndexSelect == 5)
         {
            this.DragMouse.IsRun = false;
            this.DragMouse.visible = false;
            this.FMousePicVisible = false;
         }
      }
      
      public function UpEvent(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         if(this.FAllIndexSelect == 0 || this.FAllIndexSelect == 2 || this.FAllIndexSelect == 5)
         {
            _loc4_ = Object(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT]);
            if(10 <= this.FIndexGobel && this.FIndexGobel <= 11)
            {
               if(this.FMousePicVisible)
               {
                  this.TongLingDevour.SetMsg(_loc4_,this.FIndexGobel - 10);
               }
            }
            else if(6 <= this.FIndexGobel && this.FIndexGobel <= 9)
            {
               _loc2_ = this.TongLingCulTivate.GetFourCellByIndex(this.FIndexGobel - 6).Draging;
               _loc3_ = this.TongLingCulTivate.GetFourCellByIndex(this.FIndexGobel - 6).isOpenThis;
               _loc4_ = Object(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT]);
               if(!_loc2_)
               {
                  if(this.FMousePicVisible)
                  {
                     if(_loc3_)
                     {
                        this.ModePeiYang.SetMsg(_loc4_.Id,this.FIndexGobel - 6,_loc4_.Level);
                        this.ModePeiYang.visible = true;
                     }
                  }
               }
            }
            else if(1 <= this.FIndexGobel && this.FIndexGobel <= 5)
            {
               _loc2_ = this.TongLingBattle.getFiveCellByIndex(this.FIndexGobel - 1).Draging;
               _loc3_ = this.TongLingBattle.getFiveCellByIndex(this.FIndexGobel - 1).IsOpenThis;
               if(this.FMousePicVisible)
               {
                  if(_loc2_)
                  {
                     this.sendTwoBao(this.TongLingBattle.getFiveCellByIndex(this.FIndexGobel - 1).Curobj);
                     this.sendTongLingZhen(_loc4_.Identifier0,_loc4_.Identifier1,this.FIndexGobel);
                  }
                  else if(_loc3_)
                  {
                     this.sendTongLingZhen(_loc4_.Identifier0,_loc4_.Identifier1,this.FIndexGobel);
                  }
               }
            }
            this.DragMouse.IsRun = false;
            this.DragMouse.visible = false;
            this.FMousePicVisible = false;
         }
      }
      
      public function sendTwoBao(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingZhenXingTake_Rep);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1.Identifier0);
         _loc3_.writeUnsignedInt(param1.Identifier1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function MouseUpdate() : void
      {
         if(this.FMousePicVisible)
         {
            this.DragMouse.UpDate();
            this.DragMouse.x = mouseX - 56;
            this.DragMouse.y = mouseY - 85;
         }
      }
      
      protected function valuation() : void
      {
         if(this.Vec_Down_Uints.length == 0)
         {
            return;
         }
         var _loc1_:int = 0;
         if(this.FOpenCellCount == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < UINTCOUNT)
            {
               this.Vec_Down_Uints[_loc1_].Content = null;
               _loc1_++;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < UINTCOUNT)
         {
            if(_loc1_ + (this.FCurIndexUint - 1) * UINTCOUNT >= this.FMesArr.length || _loc1_ + (this.FCurIndexUint - 1) * UINTCOUNT >= this.FMesArr.length)
            {
               this.Vec_Down_Uints[_loc1_].Content = null;
               if(this.FOpenCellCount > _loc1_ + (this.FCurIndexUint - 1) * UINTCOUNT)
               {
                  this.Vec_Down_Uints[_loc1_].Lock = false;
               }
               else
               {
                  this.Vec_Down_Uints[_loc1_].Lock = true;
               }
            }
            else
            {
               this.Vec_Down_Uints[_loc1_].Lock = false;
               this.Vec_Down_Uints[_loc1_].Content = this.FMesArr[_loc1_ + (this.FCurIndexUint - 1) * UINTCOUNT];
            }
            _loc1_++;
         }
      }
      
      public function setPerTure(param1:int) : void
      {
         var _loc3_:int = 0;
         this.FAllPage = Math.ceil(this.FMesArr.length / UINTCOUNT);
         var _loc2_:int = 0;
         while(_loc2_ < this.FMesArr.length)
         {
            this.FMesArr[_loc2_].isSelect = 0;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.Vec_Down_Uints.length)
         {
            this.Vec_Down_Uints[_loc2_].selectStatus = false;
            _loc2_++;
         }
         if(this.FAllIndexSelect == 0 || this.FAllIndexSelect == 2)
         {
            return;
         }
         _loc3_ = this.FCurIndexUint;
         if(this.FCurIndexSelect + (this.FCurIndexUint - 1) * UINTCOUNT >= this.FMesArr.length)
         {
            if(this.FMesArr.length == 0)
            {
               this.TongLingEvolve.SetMsg(null);
               this.TongLingAnimal.SetMsg(null);
               this.TongLingPractice.SetMsg(null);
               return;
            }
            this.FCurIndexSelect = 0;
            if(1 < this.FCurIndexUint)
            {
               _loc3_ = this.FCurIndexUint - 1;
            }
         }
         this.FMesArr[this.FCurIndexSelect + (_loc3_ - 1) * UINTCOUNT].isSelect = 1;
         this.Vec_Down_Uints[this.FCurIndexSelect].selectStatus = true;
         if(this.FAllIndexSelect == 1)
         {
            this.TongLingAnimal.SetMsg(this.FMesArr[this.FCurIndexSelect + (_loc3_ - 1) * UINTCOUNT]);
         }
         else if(this.FAllIndexSelect == 3)
         {
            this.TongLingEvolve.SetMsg(this.FMesArr[this.FCurIndexSelect + (_loc3_ - 1) * UINTCOUNT]);
         }
         else if(this.FAllIndexSelect == 4)
         {
            if(this.FMesArr[this.FCurIndexSelect + (_loc3_ - 1) * UINTCOUNT].isPeiYang)
            {
               EffectGenerateText(STRING_TONGLING.TONGLING_71);
            }
            this.TongLingPractice.SetMsg(this.FMesArr[this.FCurIndexSelect + (_loc3_ - 1) * UINTCOUNT]);
         }
         else if(this.FAllIndexSelect == 5)
         {
            this.TongLingDevour.Reset();
            this.Vec_Down_Uints[this.FCurIndexSelect].selectStatus = false;
         }
      }
      
      public function back_PeiYang(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingPeiYang_Rep);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(Object(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT]).Identifier0);
         _loc3_.writeUnsignedInt(Object(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT]).Identifier1);
         _loc3_.writeUnsignedInt(param1.mode);
         _loc3_.writeUnsignedInt(param1.selsect);
         _loc3_.writeUnsignedInt(int(param1.curPosition) + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         var _loc4_:Object = Object(this.FMesArr[this.FCurIndexSelect + (this.FCurPage - 1) * UINTCOUNT]);
         var _loc5_:Object = {
            "Scr":param1.Scr,
            "AllExp":param1.AllExp,
            "curPosition":param1.curPosition,
            "id":_loc4_.Id,
            "Identifier0":_loc4_.Identifier0,
            "Identifier1":_loc4_.Identifier1,
            "endtime":10,
            "allTime":param1.allTime,
            "level":_loc4_.Level,
            "CurExp":_loc4_.CurExp
         };
         this.PeiYang_Obj = _loc5_;
      }
      
      public function Pei_Yang_Back(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         _loc4_ = param1.Data;
         _loc2_ = int(_loc4_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc3_ = int(_loc4_.readUnsignedInt());
         this.PeiYang_Obj.endtime = _loc3_;
         this.TongLingCulTivate.GetFourCellByIndex(int(this.PeiYang_Obj.curPosition)).setMsgObj(this.PeiYang_Obj);
         this.TongLingCulTivate.GetFourCellByIndex(int(this.PeiYang_Obj.curPosition)).Draging = 1;
         this.TongLingCulTivate.GetFourCellByIndex(int(this.PeiYang_Obj.curPosition)).setScr = false;
         this.TongLingCulTivate.GetFourCellByIndex(int(this.PeiYang_Obj.curPosition)).setLittle = true;
         this.ModePeiYang.visible = false;
      }
      
      protected function TraceMsg(param1:String) : void
      {
         EffectGenerateText(param1);
      }
      
      public function extendSend() : void
      {
         var _loc1_:String = null;
         if(this.FOpenCellCount >= this.FAllCellCount)
         {
            EffectGenerateText(STRING_TONGLING.TONGLING_K);
            return;
         }
         _loc1_ = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_TongLing_Expend).DescribeString,this.AnimalCellBuys[this.FOpenCellCount][1],this.getUint(this.AnimalCellBuys[this.FOpenCellCount][0]));
         this.FPopWindow.Text = _loc1_;
         this.FPopWindow.visible = true;
      }
      
      public function speed(param1:int, param2:int, param3:String, param4:uint, param5:uint) : void
      {
         var _loc6_:TPacket = null;
         var _loc7_:ByteArray = null;
         if(param2 == 1)
         {
            _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingUseProp_Rep);
         }
         else
         {
            _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingGet_Rep);
         }
         _loc7_ = _loc6_.Data;
         _loc7_.writeUnsignedInt(param4);
         _loc7_.writeUnsignedInt(param5);
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
      }
      
      public function OneKeySpeed(param1:int, param2:int, param3:String, param4:uint, param5:uint) : void
      {
         var _loc6_:TPacket = null;
         var _loc7_:ByteArray = null;
         _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OneKeyTrainUseItem_Rep);
         _loc7_ = _loc6_.Data;
         _loc7_.writeUnsignedInt(param4);
         _loc7_.writeUnsignedInt(param5);
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
      }
      
      protected function sendTongLingZhen(param1:uint, param2:uint, param3:int) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingZhenXingPut_Rep);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param1);
         _loc5_.writeUnsignedInt(param2);
         _loc5_.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function BackCloseFun() : void
      {
         this.ShowPanelByType(0);
      }
      
      protected function BuyTuFeiC_S(param1:int, param2:int) : void
      {
         this.ShowPanelByType(2);
      }
      
      protected function TuFeiPeiYangC_S(param1:Object, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         this.CurCostType = 7;
         this.NimeiObj = param1;
         this.Nimeicout = param2;
         this.Nimeitype = param3;
         if(this.FUIWindowConfirmationSell.IsSelected || param4 == 0)
         {
            _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AddExp_Stone_Rep);
            _loc6_ = _loc5_.Data;
            _loc6_.writeUnsignedInt(this.NimeiObj.Identifier0);
            _loc6_.writeUnsignedInt(this.NimeiObj.Identifier1);
            _loc6_.writeUnsignedInt(this.Nimeicout);
            _loc6_.writeUnsignedInt(this.Nimeitype);
            SNetworkCore.Transceiver.PacketTransmit(_loc5_);
         }
         else
         {
            this.FUIWindowConfirmationSell.SetCheckBox(true);
            this.FUIWindowConfirmationSell.SetHtml = TUtilityString.Format(STRING_TONGLING.TONGLING_91,param4);
            this.FUIWindowConfirmationSell.visible = true;
         }
      }
      
      protected function WindowConfirmationSellOnOK(param1:Object = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.CurCostType == 6)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AddExp_Buy_Stone);
            _loc3_ = _loc2_.Data;
            _loc3_.writeUnsignedInt(this.FThisDate.Identifier);
            _loc3_.writeUnsignedInt(1);
         }
         else
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AddExp_Stone_Rep);
            _loc3_ = _loc2_.Data;
            _loc3_.writeUnsignedInt(this.NimeiObj.Identifier0);
            _loc3_.writeUnsignedInt(this.NimeiObj.Identifier1);
            _loc3_.writeUnsignedInt(this.Nimeicout);
            _loc3_.writeUnsignedInt(this.Nimeitype);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function BuyBackFun(param1:TBB_BuyRapid) : void
      {
         this.FThisDate = param1;
         this.CurCostType = 6;
         this.FUIWindowConfirmationSell.SetCheckBox(false);
         this.FUIWindowConfirmationSell.SetHtml = TUtilityString.Format(STRING_TONGLING.TONGLING_89,param1.PriceArr[1],param1.Name);
         this.FUIWindowConfirmationSell.visible = true;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingAnimal_Back,this.Animal_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingDrop_Back,this.Animal_Drop);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingFrom_Back,this.Animal_From);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingBag_Back,this.Animal_Bag);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingPeiYang_Back,this.Pei_Yang_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingOpenLocation_Back,this.Pei_Yang_Open);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingUseProp_Back,this.Pei_Yang_DaoJu);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingGet_Back,this.Pei_Yang_Get);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingDianBuy_Back,this.Pei_Yang_BUY);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingChange_Back,this.Pei_Yang_Change);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingJinHua_Back,this.Jin_Hua_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingZhenXingOpen_Back,this.Zhen_Xing_Open_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingZhenXingPut_Back,this.Zhen_Xing_Put_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingZhenXingTake_Back,this.Zhen_Xing_Take_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingAllExp_Back,this.All_Exp_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingZhenXingZhen_Sing_Back,this.Zhen_Xing_Sing_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLing_AllMsg_two,this.Zhen_Xing_two_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLingShouAtrr_Sing_Back,this.Shou_Atrr_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLing_from_Back,this.From_Back);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLing_AllMsg_Back,this.PerformPacket_SC_TongLing);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TongLing_AllMsg_one,this.OnUpdateLittlePetInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_OneKeyTrainUseItem_Ret,this.OneKeyTrainUseItemRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WashBeast_Ret,this.OnWashBeastRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WashBeastConfirm_Ret,this.OnWashBeastConfirmRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DevourBeast_Ret,this.OnDevourBeastRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Stone_Rep,this.PACKETID_SC_Stone_Rep);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Buy_Stone,this.PACKETID_SC_Buy_Stone);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ContractUpgrade,this.ContractUpgrace_Back);
      }
      
      public function set UpdateLittlePetInfo(param1:Function) : void
      {
         this.FOnUpdateLittlePetInfo = param1;
      }
      
      protected function OnUpdateLittlePetInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(this.FOnUpdateLittlePetInfo != null)
         {
            this.FOnUpdateLittlePetInfo(_loc3_);
         }
      }
      
      protected function OneKeyTrainUseItemRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         _loc4_ = _loc3_.readUnsignedInt();
         this.TongLingCulTivate.GetFourCellByIndex(_loc4_ - 1).FIsCanClick = 0;
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc5_ = _loc3_.readUnsignedInt();
         this.TongLingCulTivate.GetFourCellByIndex(_loc4_ - 1).SetEndTime(_loc5_);
         EffectGenerateText(STRING_TONGLING.TONGLING_60);
      }
      
      protected function OnWashBeastRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TTongLingData = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            this.TongLingPractice.Updata();
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = this.FTongLingDatas.GetTongLingDataById64(_loc4_,_loc5_);
         _loc6_.ClearWashingAttribute();
         _loc8_ = _loc2_.readUnsignedShort();
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = _loc2_.readUnsignedInt();
            _loc10_ = _loc2_.readUnsignedInt();
            _loc6_.AddWashingAttribute(_loc9_,_loc10_);
            _loc7_++;
         }
         this.TongLingPractice.Updata();
      }
      
      protected function OnWashBeastConfirmRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TTongLingData = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc4_ = _loc2_.readUnsignedInt();
         _loc7_ = this.FTongLingDatas.GetTongLingDataById64(_loc5_,_loc6_);
         if(_loc4_ == 0)
         {
            _loc7_.ClearWashingAttribute();
         }
         else
         {
            _loc7_.UpdateWashingDateToWashData();
            EffectGenerateText(STRING_TONGLING.TONGLING_69);
         }
         this.TongLingPractice.Updata();
      }
      
      protected function PACKETID_SC_Buy_Stone(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(STRING_TONGLING.TONGLING_90);
         this.FProcessorTuFeiPeiYang.UpdateView();
      }
      
      protected function PACKETID_SC_Stone_Rep(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FProcessorTuFeiPeiYang.UpdateView();
      }
      
      protected function OnDevourBeastRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TTongLingData = null;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         _loc11_ = _loc2_.readUnsignedInt();
         _loc8_ = SLogicsCore.TongLingDatas.GetTongLingDataById64(_loc4_,_loc5_);
         _loc8_.ClearWashAttribute();
         _loc10_ = _loc2_.readUnsignedShort();
         _loc9_ = 0;
         while(_loc9_ < _loc10_)
         {
            _loc12_ = _loc2_.readUnsignedInt();
            _loc13_ = _loc2_.readUnsignedInt();
            _loc8_.AddWashAttribute(_loc12_,_loc13_);
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < this.FMesArr.length)
         {
            if(this.FMesArr[_loc9_].Identifier0 == _loc4_ && this.FMesArr[_loc9_].Identifier1 == _loc5_)
            {
               this.FMesArr[_loc9_].CurExp = _loc2_.readUnsignedInt();
               this.FMesArr[_loc9_].Level = _loc2_.readUnsignedInt();
               break;
            }
            _loc9_++;
         }
         EffectGenerateText(STRING_TONGLING.TONGLING_72);
      }
      
      public function PerformPacket_SC_TongLing(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         var _loc4_:TongLingOtherMsg = TongLingOtherMsg.getTipIntence(null);
         _loc4_.rendData(_loc3_);
         _loc3_.position = 0;
         var _loc5_:TongLingOtherMsgCopy = TongLingOtherMsgCopy.getTipIntence(null);
         _loc5_.rendData(_loc3_);
         if(this.FUpdataWindowHeroInfor != null)
         {
            this.FUpdataWindowHeroInfor(_loc2_);
         }
      }
      
      public function PaiXu() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.FMesArr.length)
         {
            if(this.FMesArr[_loc1_].Position == 1)
            {
               this.FMesArr[_loc1_].index = 3;
            }
            else if(this.FMesArr[_loc1_].Position >= 2)
            {
               this.FMesArr[_loc1_].index = 2;
            }
            else
            {
               this.FMesArr[_loc1_].index = 1;
            }
            _loc1_++;
         }
         this.FMesArr.sortOn("index",Array.DESCENDING | Array.NUMERIC);
      }
      
      public function Animal_Back(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TTongLingData = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:Object = null;
         var _loc25_:Array = null;
         var _loc26_:Object = null;
         this.FMesArr.length = 0;
         this.FOpenCellCount = 0;
         _loc4_ = param1.Data;
         _loc5_ = int(_loc4_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc13_ = _loc4_.readUnsignedInt();
            _loc14_ = _loc4_.readUnsignedInt();
            _loc15_ = int(_loc4_.readUnsignedInt());
            _loc16_ = int(_loc4_.readUnsignedInt());
            _loc17_ = int(_loc4_.readUnsignedInt());
            _loc18_ = int(_loc4_.readUnsignedInt());
            _loc19_ = int(_loc4_.readUnsignedInt());
            _loc20_ = int(_loc4_.readUnsignedInt());
            _loc21_ = int(_loc4_.readUnsignedInt());
            _loc22_ = int(_loc4_.readUnsignedInt());
            _loc23_ = int(_loc4_.readUnsignedInt());
            this.FMesArr.push({
               "Identifier0":_loc13_,
               "Identifier1":_loc14_,
               "Id":_loc15_,
               "Position":_loc16_,
               "Status":_loc17_,
               "CurExp":_loc19_,
               "Level":_loc18_,
               "index":0,
               "PosPeiYang":_loc20_,
               "ModPeiYang":_loc21_,
               "TypePeiYang":_loc22_,
               "TimeOver":_loc23_,
               "isTongLingZhen":_loc16_,
               "isPeiYang":0,
               "isCanMove":0,
               "isCanMove2":0,
               "num":20,
               "bai":100,
               "lock":0,
               "isSelect":0,
               "isCanEvolve":0
            });
            if(_loc16_ != 0)
            {
               this.FMesArr[_loc2_].isCanMove2 = 1;
               _loc24_ = {
                  "curPosition":_loc16_,
                  "Id":_loc15_,
                  "Identifier0":_loc13_,
                  "Identifier1":_loc14_,
                  "Level":_loc18_
               };
               this.FIntiTongLingTempT.push(_loc24_);
            }
            if(_loc20_ != 0)
            {
               this.FMesArr[_loc2_].isPeiYang = 1;
               this.FMesArr[_loc2_].isCanMove = 1;
               _loc25_ = this.showExp(_loc15_,_loc21_,_loc22_);
               _loc26_ = {
                  "Scr":this.GetModeName(_loc21_),
                  "AllExp":_loc25_[0],
                  "curPosition":_loc20_,
                  "id":_loc15_,
                  "Identifier0":_loc13_,
                  "Identifier1":_loc14_,
                  "endtime":_loc23_,
                  "allTime":_loc25_[1],
                  "level":_loc18_,
                  "CurExp":_loc19_
               };
               this.FIntiTongLingTempP.push(_loc26_);
            }
            _loc7_ = new TTongLingData();
            _loc7_.Id0 = _loc13_;
            _loc7_.Id1 = _loc14_;
            _loc8_ = _loc4_.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc8_)
            {
               _loc9_ = _loc4_.readUnsignedInt();
               _loc10_ = _loc4_.readUnsignedInt();
               _loc7_.AddWashAttribute(_loc9_,_loc10_);
               _loc3_++;
            }
            _loc8_ = _loc4_.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc8_)
            {
               _loc9_ = _loc4_.readUnsignedInt();
               _loc10_ = _loc4_.readUnsignedInt();
               _loc7_.AddWashingAttribute(_loc9_,_loc10_);
               _loc3_++;
            }
            this.FTongLingDatas.AddTongLingData(_loc7_);
            _loc2_++;
         }
         this.FOpenCellCount = _loc4_.readUnsignedInt();
         this.SetJnHuCount(_loc4_.readUnsignedInt());
         var _loc11_:int = int(_loc4_.readUnsignedShort());
         this.FOpenedArrs.length = 0;
         this.FTongLingArrs.length = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc11_)
         {
            this.FOpenedArrs.push(_loc4_.readUnsignedInt());
            _loc2_++;
         }
         var _loc12_:int = int(_loc4_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc12_)
         {
            this.FTongLingArrs.push(_loc4_.readUnsignedInt());
            _loc2_++;
         }
         this.FTongLingDatas.ContractID = _loc4_.readUnsignedInt();
         this.FTongLingDatas.CurExp = _loc4_.readUnsignedInt();
         this.FTongLingDatas.ContractCount = _loc4_.readUnsignedInt();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PaiXu();
         this.setPerTure(this.FCurIndexSelect);
         this.valuation();
         this.setBtnLR(this.FAllCellCount);
         this.heihaya();
         this.yahahei();
         this.addPetToCellT(this.FIntiTongLingTempT);
         this.addPetToCellP(this.FIntiTongLingTempP);
      }
      
      protected function addPetToCellP(param1:Array) : void
      {
         if(param1.length == 0)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.TongLingCulTivate.GetFourCellByIndex(int(param1[_loc2_].curPosition) - 1).setMsgObj(param1[_loc2_]);
            this.TongLingCulTivate.GetFourCellByIndex(int(param1[_loc2_].curPosition) - 1).CanRefleash = true;
            this.TongLingCulTivate.GetFourCellByIndex(int(param1[_loc2_].curPosition) - 1).setScr = false;
            this.TongLingCulTivate.GetFourCellByIndex(int(param1[_loc2_].curPosition) - 1).setLittle = true;
            _loc2_++;
         }
      }
      
      protected function addPetToCellT(param1:Array) : void
      {
         if(param1.length == 0)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.TongLingBattle.getFiveCellByIndex(int(param1[_loc2_].curPosition) - 1).SetMsgObj(param1[_loc2_]);
            this.TongLingBattle.getFiveCellByIndex(int(param1[_loc2_].curPosition) - 1).Draging = 1;
            _loc2_++;
         }
      }
      
      protected function showExp(param1:int, param2:int, param3:int) : Array
      {
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc4_:TBB_Status = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,param1) as TBB_Status;
         var _loc5_:int = 10000 + _loc4_.Rarity * 10 + param2;
         var _loc6_:TBB_Train = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Train,_loc5_) as TBB_Train;
         switch(param3)
         {
            case 0:
               return new Array(_loc6_.GetExp,_loc6_.TrainTime);
            case 1:
               _loc8_ = _loc6_.ExtraExp1;
               break;
            case 2:
               _loc8_ = _loc6_.ExtraExp2;
               break;
            case 3:
               _loc8_ = _loc6_.ExtraExp3;
         }
         _loc7_ = _loc8_.substr(1,_loc8_.length - 2).split(",");
         return new Array(_loc6_.GetExp * Number(_loc7_[0]),_loc6_.TrainTime);
      }
      
      public function heihaya() : void
      {
         var _loc2_:int = 0;
         if(this.FMCPanelRoot == null)
         {
            return;
         }
         var _loc1_:int = 0;
         if(this.FTongLingArrs.length != 0)
         {
            _loc2_ = this.FTongLingArrs.indexOf(5);
            if(_loc2_ != -1)
            {
               this.TongLingBattle.ChangePostion();
            }
         }
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            if(_loc1_ == 4)
            {
               this.TongLingBattle.getFiveCellByIndex(_loc1_).IsVisibel_levelOpen = true;
               this.TongLingBattle.getFiveCellByIndex(_loc1_).HowLvelOpen(this.AtrConditions[4][0],this.AtrConditions[4][1]);
               this.TongLingBattle.getFiveCellByIndex(_loc1_).IsOpenThis = 0;
            }
            else
            {
               this.TongLingBattle.getFiveCellByIndex(_loc1_).IsVisibel_levelOpen = true;
               this.TongLingBattle.getFiveCellByIndex(_loc1_).IsOpenThis = 0;
               this.TongLingBattle.getFiveCellByIndex(_loc1_).HowLvelOpen(this.AtrConditions[_loc1_][0],this.AtrConditions[_loc1_][1]);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FTongLingArrs.length)
         {
            this.TongLingBattle.getFiveCellByIndex(this.FTongLingArrs[_loc1_] - 1).IsVisibel_levelOpen = false;
            this.TongLingBattle.getFiveCellByIndex(this.FTongLingArrs[_loc1_] - 1).IsOpenThis = 1;
            _loc1_++;
         }
      }
      
      public function yahahei() : void
      {
         var _loc2_:int = 0;
         if(this.FMCPanelRoot == null)
         {
            return;
         }
         var _loc1_:int = 0;
         if(this.FOpenedArrs.length != 0)
         {
            _loc2_ = this.FOpenedArrs.indexOf(4);
            if(_loc2_ != -1)
            {
               this.TongLingCulTivate.ChangePostion();
            }
         }
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            if(_loc1_ == 3)
            {
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).setSimpleBtn = true;
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).setLevelScr = false;
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).setScr = false;
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).setLittle = false;
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).isOpenThis = 0;
            }
            else
            {
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).setSimpleBtn = false;
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).setLevelScr = true;
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).isOpenThis = 0;
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).setLevelScrText = this.FFosterOpens[_loc1_][1];
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).setScr = false;
               this.TongLingCulTivate.GetFourCellByIndex(_loc1_).setLittle = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FOpenedArrs.length)
         {
            if(this.TongLingCulTivate.GetFourCellByIndex(this.FOpenedArrs[_loc1_] - 1).Draging)
            {
               this.TongLingCulTivate.GetFourCellByIndex(this.FOpenedArrs[_loc1_] - 1).setScr = false;
               this.TongLingCulTivate.GetFourCellByIndex(this.FOpenedArrs[_loc1_] - 1).setLittle = true;
            }
            else
            {
               this.TongLingCulTivate.GetFourCellByIndex(this.FOpenedArrs[_loc1_] - 1).setScr = true;
               this.TongLingCulTivate.GetFourCellByIndex(this.FOpenedArrs[_loc1_] - 1).setLittle = false;
            }
            this.TongLingCulTivate.GetFourCellByIndex(this.FOpenedArrs[_loc1_] - 1).setSimpleBtn = false;
            this.TongLingCulTivate.GetFourCellByIndex(this.FOpenedArrs[_loc1_] - 1).setLevelScr = false;
            this.TongLingCulTivate.GetFourCellByIndex(this.FOpenedArrs[_loc1_] - 1).isOpenThis = 1;
            _loc1_++;
         }
      }
      
      public function Pei_Yang_Change(param1:TPacket) : void
      {
         var _loc2_:TTongLingData = null;
         var _loc3_:ByteArray = null;
         var _loc18_:Object = null;
         _loc3_ = param1.Data;
         var _loc4_:uint = _loc3_.readUnsignedInt();
         var _loc5_:uint = _loc3_.readUnsignedInt();
         var _loc6_:int = int(_loc3_.readUnsignedInt());
         var _loc7_:int = int(_loc3_.readUnsignedInt());
         var _loc8_:int = int(_loc3_.readUnsignedInt());
         var _loc9_:int = int(_loc3_.readUnsignedInt());
         var _loc10_:int = int(_loc3_.readUnsignedInt());
         var _loc11_:int = int(_loc3_.readUnsignedInt());
         var _loc12_:int = int(_loc3_.readUnsignedInt());
         var _loc13_:int = int(_loc3_.readUnsignedInt());
         var _loc14_:int = int(_loc3_.readUnsignedInt());
         var _loc15_:Object = {
            "Identifier0":_loc4_,
            "Identifier1":_loc5_,
            "Id":_loc6_,
            "Position":_loc7_,
            "Status":_loc8_,
            "CurExp":_loc10_,
            "Level":_loc9_,
            "index":50,
            "PosPeiYang":_loc11_,
            "ModPeiYang":_loc12_,
            "TypePeiYang":_loc13_,
            "TimeOver":_loc14_,
            "isTongLingZhen":_loc7_,
            "isPeiYang":0,
            "isCanMove":0,
            "isCanMove2":0,
            "num":20,
            "bai":100,
            "lock":0,
            "isSelect":0,
            "isCanEvolve":0
         };
         var _loc16_:int = 0;
         var _loc17_:int = 1;
         var _loc19_:int = 0;
         while(_loc19_ < this.FMesArr.length)
         {
            if(this.FMesArr[_loc19_].Identifier0 == _loc4_ && this.FMesArr[_loc19_].Identifier1 == _loc5_)
            {
               _loc18_ = Object(this.FMesArr[_loc19_]);
               if(_loc7_ != 0)
               {
                  this.TongLingBattle.getFiveCellByIndex(_loc7_ - 1).SetMsgObj(_loc15_);
                  _loc18_.isCanMove2 = 1;
                  this.TongLingBattle.getFiveCellByIndex(_loc7_ - 1).IsOpenThis = 0;
                  this.TongLingBattle.getFiveCellByIndex(_loc7_ - 1).Draging = 1;
               }
               else if(int(this.FMesArr[_loc19_].Position) != 0 && _loc7_ == 0)
               {
                  this.TongLingBattle.getFiveCellByIndex(int(this.FMesArr[_loc19_].Position) - 1).SetMsgObj(null);
                  this.TongLingBattle.getFiveCellByIndex(int(this.FMesArr[_loc19_].Position) - 1).SetNull();
                  this.TongLingBattle.getFiveCellByIndex(int(this.FMesArr[_loc19_].Position) - 1).Draging = 0;
                  this.TongLingBattle.getFiveCellByIndex(int(this.FMesArr[_loc19_].Position) - 1).IsOpenThis = 1;
               }
               if(this.FMesArr[_loc19_].Position == _loc7_)
               {
                  _loc17_ = 0;
               }
               this.FMesArr[_loc19_].Identifier0 = _loc4_;
               this.FMesArr[_loc19_].Identifier1 = _loc5_;
               this.FMesArr[_loc19_].Id = _loc6_;
               this.FMesArr[_loc19_].Position = _loc7_;
               this.FMesArr[_loc19_].Status = _loc8_;
               this.FMesArr[_loc19_].CurExp = _loc10_;
               this.FMesArr[_loc19_].Level = _loc9_;
               this.FMesArr[_loc19_].PosPeiYang = _loc11_;
               this.FMesArr[_loc19_].ModPeiYang = _loc12_;
               this.FMesArr[_loc19_].TypePeiYang = _loc13_;
               this.FMesArr[_loc19_].TimeOver = _loc14_;
               this.FMesArr[_loc19_].isTongLingZhen = _loc7_;
               if(_loc11_ == 0)
               {
                  this.FMesArr[_loc19_].isCanMove = 0;
                  this.FMesArr[_loc19_].isPeiYang = 0;
               }
               else
               {
                  this.FMesArr[_loc19_].isCanMove = 1;
                  this.FMesArr[_loc19_].isPeiYang = 1;
               }
               if(_loc7_ == 0)
               {
                  this.FMesArr[_loc19_].isCanMove2 = 0;
               }
               else
               {
                  this.FMesArr[_loc19_].isCanMove2 = 1;
               }
               _loc16_++;
            }
            _loc19_++;
         }
         if(_loc16_ == 0)
         {
            this.FMesArr.push(_loc15_);
            this.FAllPage = Math.ceil(this.FMesArr.length / UINTCOUNT);
            _loc2_ = new TTongLingData();
            _loc2_.Id0 = _loc4_;
            _loc2_.Id1 = _loc5_;
            this.FTongLingDatas.AddTongLingData(_loc2_);
         }
         if(_loc17_)
         {
            this.PaiXu();
         }
         if(this.FMCPanelRoot == null)
         {
            return;
         }
         this.setPerTure(this.FCurIndexSelect);
         this.valuation();
         this.FUpdateHeroPower(null);
      }
      
      public function Animal_Drop(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:ByteArray = null;
         var _loc6_:int = 0;
         var _loc8_:Array = null;
         _loc5_ = param1.Data;
         _loc2_ = int(_loc5_.readUnsignedInt());
         _loc3_ = _loc5_.readUnsignedInt();
         _loc4_ = _loc5_.readUnsignedInt();
         _loc6_ = int(_loc5_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         if(this.FMesArr.length == 0)
         {
            return;
         }
         var _loc7_:int = 0;
         while(_loc7_ < this.FMesArr.length)
         {
            if(this.FMesArr[_loc7_].Identifier0 == _loc3_ && this.FMesArr[_loc7_].Identifier1 == _loc4_)
            {
               this.FMesArr.splice(_loc7_,1);
               break;
            }
            _loc7_++;
         }
         if(_loc6_ != 0)
         {
            _loc8_ = STRING_TONGLING.TONGLING_18.split("&");
            EffectGenerateText(_loc8_[0] + _loc6_ + _loc8_[1]);
         }
         this.setPerTure(this.FCurIndexSelect);
         this.valuation();
      }
      
      public function Animal_From(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
      }
      
      public function Animal_Bag(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FOpenCellCount = _loc3_.readUnsignedInt();
         this.setBtnLR(this.FAllCellCount);
         this.setPerTure(this.FCurIndexSelect);
         this.valuation();
      }
      
      public function Pei_Yang_DaoJu(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         _loc4_ = param1.Data;
         _loc2_ = int(_loc4_.readUnsignedInt());
         _loc3_ = int(_loc4_.readUnsignedInt());
         this.TongLingCulTivate.GetFourCellByIndex(_loc3_ - 1).FIsCanClick = 0;
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.TongLingCulTivate.GetFourCellByIndex(_loc3_ - 1).addTime();
      }
      
      public function Pei_Yang_Get(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         _loc4_ = param1.Data;
         _loc2_ = int(_loc4_.readUnsignedInt());
         _loc3_ = int(_loc4_.readUnsignedInt());
         _loc5_ = int(_loc4_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc6_:Array = STRING_TONGLING.TONGLING_19.split("&");
         var _loc7_:String = this.TongLingCulTivate.GetFourCellByIndex(_loc3_ - 1).NameStr + _loc6_[0] + _loc5_ + _loc6_[1];
         EffectGenerateText(_loc7_);
         this.TongLingCulTivate.GetFourCellByIndex(_loc3_ - 1).setNull();
         this.TongLingCulTivate.GetFourCellByIndex(_loc3_ - 1).CanRefleash = false;
         this.TongLingCulTivate.GetFourCellByIndex(_loc3_ - 1).Msg = null;
         this.TongLingCulTivate.GetFourCellByIndex(_loc3_ - 1).Draging = 0;
         this.TongLingCulTivate.GetFourCellByIndex(_loc3_ - 1).setScr = true;
         this.TongLingCulTivate.GetFourCellByIndex(_loc3_ - 1).setLittle = false;
      }
      
      public function Pei_Yang_BUY(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc4_:Array = STRING_TONGLING.TONGLING_16.split("&");
         EffectGenerateText(_loc4_[0] + TProcessorShopJinHua.BuyAnimalCost + _loc4_[1]);
      }
      
      public function Jin_Hua_Back(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         _loc4_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc5_:Array = STRING_TONGLING.TONGLING_17.split("&");
         EffectGenerateText(_loc5_[0] + _loc4_ + _loc5_[1]);
         this.TongLingEvolve.OpenMe();
      }
      
      public function Zhen_Xing_Open_Back(param1:TPacket) : void
      {
      }
      
      public function Zhen_Xing_two_Back(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FOpenedArrs.length = 0;
         var _loc3_:int = int(_loc2_.readUnsignedShort());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this.FOpenedArrs.push(_loc2_.readUnsignedInt());
            _loc4_++;
         }
         this.yahahei();
      }
      
      public function Zhen_Xing_Sing_Back(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FTongLingArrs.length = 0;
         var _loc3_:int = int(_loc2_.readUnsignedShort());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this.FTongLingArrs.push(_loc2_.readUnsignedInt());
            _loc4_++;
         }
         this.heihaya();
      }
      
      public function Pei_Yang_Open(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FOpenedArrs.push(4);
         this.yahahei();
      }
      
      public function Zhen_Xing_Put_Back(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         _loc4_ = param1.Data;
         _loc2_ = int(_loc4_.readUnsignedInt());
         _loc3_ = int(_loc4_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
      }
      
      public function Zhen_Xing_Take_Back(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         _loc4_ = param1.Data;
         _loc2_ = int(_loc4_.readUnsignedInt());
         _loc3_ = int(_loc4_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
      }
      
      public function From_Back(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         _loc4_ = param1.Data;
         _loc2_ = int(_loc4_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
      }
      
      public function All_Exp_Back(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         this.SetJnHuCount(_loc2_);
      }
      
      public function SetJnHuCount(param1:int) : void
      {
         this.FEvolutionPoint = param1;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         TextField(this.FTabArr[3]["TF_Text_All"]).text = String(param1);
         if(this.ShopJinHua != null)
         {
            this.ShopJinHua.SetPoint(this.FEvolutionPoint);
         }
      }
      
      public function Shou_Atrr_Back(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = 0;
         while(_loc2_ < this.ATT_Count)
         {
            this.FTongLingDatas.TongLingAtt[_loc2_] = _loc3_.readUnsignedInt();
            _loc2_++;
         }
         this.UpdateAttUI();
      }
      
      public function UpdateAttUI() : void
      {
         var _loc1_:TTongLingData = null;
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         TextField(this.FTabArr[0]["TF_Text"]).text = String(this.FTongLingDatas.TongLingAtt[0]);
         TextField(this.FTabArr[0]["TF_Text1"]).text = String(this.FTongLingDatas.TongLingAtt[1]);
         TextField(this.FTabArr[0]["TF_Text2"]).text = String(this.FTongLingDatas.TongLingAtt[2]);
         TextField(this.FTabArr[0]["TF_Text3"]).text = String(this.FTongLingDatas.TongLingAtt[3]);
         TextField(this.FTabArr[0]["TF_Text4"]).text = String(this.FTongLingDatas.TongLingAtt[4]);
         TextField(this.FTabArr[0]["TF_Text5"]).text = String(this.FTongLingDatas.TongLingAtt[5]);
         TextField(this.FTabArr[0]["TF_Text000"]).text = String(this.FTongLingDatas.TongLingAtt[6]);
         TextField(this.FTabArr[0]["TF_Text001"]).text = String(this.FTongLingDatas.TongLingAtt[7]);
         TextField(this.FTabArr[0]["TF_Text002"]).text = String(this.FTongLingDatas.TongLingAtt[8]);
         TextField(this.FTabArr[0]["TF_Text003"]).text = String(this.FTongLingDatas.TongLingAtt[9]);
         TextField(this.FTabArr[0]["TF_Text004"]).text = String(this.FTongLingDatas.TongLingAtt[10]);
         TextField(this.FTabArr[0]["TF_Text005"]).text = String(this.FTongLingDatas.TongLingAtt[11]);
         TextField(this.FTabArr[0]["TF_Text00"]).text = String(this.FTongLingDatas.TongLingAtt[12]);
         TextField(this.FTabArr[0]["TF_Text01"]).text = String(this.FTongLingDatas.TongLingAtt[13]);
         TextField(this.FTabArr[0]["TF_Text02"]).text = String(this.FTongLingDatas.TongLingAtt[14]);
         TextField(this.FTabArr[0]["TF_Text03"]).text = String(this.FTongLingDatas.TongLingAtt[15]);
         TextField(this.FTabArr[0]["TF_Text04"]).text = String(this.FTongLingDatas.TongLingAtt[16]);
         TextField(this.FTabArr[0]["TF_Text05"]).text = String(this.FTongLingDatas.TongLingAtt[17]);
         TextField(this.FTabArr[0]["TF_Text0000"]).text = String(this.FTongLingDatas.TongLingAtt[18]);
         TextField(this.FTabArr[0]["TF_Text0001"]).text = String(this.FTongLingDatas.TongLingAtt[19]);
         TextField(this.FTabArr[0]["TF_Text0002"]).text = String(this.FTongLingDatas.TongLingAtt[20]);
         TextField(this.FTabArr[0]["TF_Text0003"]).text = String(this.FTongLingDatas.TongLingAtt[21]);
         TextField(this.FTabArr[0]["TF_Text0004"]).text = String(this.FTongLingDatas.TongLingAtt[22]);
         TextField(this.FTabArr[0]["TF_Text0005"]).text = String(this.FTongLingDatas.TongLingAtt[23]);
      }
      
      public function get UpdateHeroPower() : Function
      {
         return this.FUpdateHeroPower;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function set UpdataWindowHeroInfor(param1:Function) : void
      {
         this.FUpdataWindowHeroInfor = param1;
      }
      
      protected function GetBaseCondition() : void
      {
         var _loc7_:TSystemLanguage = null;
         var _loc1_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_zhen) as TConfigValue;
         this.AtrConditions = _loc1_.Value as Vector.<Object>;
         var _loc2_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_Attr) as TConfigValue;
         this.AttrJiaChengs = _loc2_.Value as Vector.<Object>;
         var _loc3_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_Buy) as TConfigValue;
         this.AnimalCellBuys = _loc3_.Value as Vector.<Object>;
         var _loc4_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_Time) as TConfigValue;
         this.FSpeedTime = _loc4_.Value as int;
         var _loc5_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_PropId) as TConfigValue;
         this.FPropId = _loc5_.Value as int;
         var _loc6_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_PeiYangOpen) as TConfigValue;
         this.FFosterOpens = _loc6_.Value as Vector.<Object>;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_CONFIGVALUE.TongLingzhne) as TSystemLanguage;
         this.FTLZ_Scr = _loc7_.Desc as String;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_CONFIGVALUE.TongLingAnimal) as TSystemLanguage;
         this.FTLS_Scr = _loc7_.Desc as String;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_CONFIGVALUE.TongLing1) as TSystemLanguage;
         this.FTL1 = _loc7_.Desc as String;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_CONFIGVALUE.TongLing2) as TSystemLanguage;
         this.FTL2 = _loc7_.Desc as String;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_CONFIGVALUE.TongLing3) as TSystemLanguage;
         this.FTL3 = _loc7_.Desc as String;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_CONFIGVALUE.TongLing4) as TSystemLanguage;
         this.FTL4 = _loc7_.Desc as String;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_CONFIGVALUE.TongLing5) as TSystemLanguage;
         this.FTL5 = _loc7_.Desc as String;
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_CONFIGVALUE.TongLing6) as TSystemLanguage;
         this.FTL6 = _loc7_.Desc as String;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_PracticeOpenLimit) as TConfigValue;
         this.FPractice_Limit = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_DevourOpenLimit) as TConfigValue;
         this.FDevour_Limit = _loc1_.Value as uint;
      }
      
      public function GetModeName(param1:int) : String
      {
         var _loc2_:String = STRING_TONGLING.TONGLING_PUTONGPEIYANG;
         switch(param1)
         {
            case 1:
               _loc2_ = STRING_TONGLING.TONGLING_PUTONGPEIYANG;
               break;
            case 2:
               _loc2_ = STRING_TONGLING.TONGLING_PZHONGJIPEIYANG;
               break;
            case 3:
               _loc2_ = STRING_TONGLING.TONGLING_PZGAOJIPEIYANG;
         }
         return _loc2_;
      }
      
      public function Back_True_False() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            if(this.TongLingCulTivate.GetFourCellByIndex(_loc1_).isOpenThis)
            {
               if(this.TongLingCulTivate.GetFourCellByIndex(_loc1_).Draging)
               {
                  if(this.TongLingCulTivate.GetFourCellByIndex(_loc1_).IsCanGet)
                  {
                     return true;
                  }
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function set OnCanGetAnimal(param1:Function) : void
      {
         this.FOnCanGetAnimal = param1;
      }
      
      public function ForBeautiful() : void
      {
         this.FOnCanGetAnimal(CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_TongLing,this.Back_True_False());
      }
      
      public function UpdateOneKeyTuFeiBtn() : void
      {
         if(this.FMesArr.length <= 0)
         {
            TGameUtil.setButtonMode(this.FMC_OneKeyTuFeiBtn,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_OneKeyTuFeiBtn,true);
         }
      }
      
      public function ContractUpgrace_Back(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readUnsignedInt();
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FTongLingDatas.ContractID = _loc2_.readUnsignedInt();
         this.FTongLingDatas.CurExp = _loc2_.readUnsignedInt();
         this.FTongLingDatas.ContractCount = _loc2_.readUnsignedInt();
         if(FOnEffectText != null)
         {
            FOnEffectText(this,STRING_LOSTSHENQI.str9);
         }
         this.TongLingBattle.UpdateContract();
         this.TongLingBattle.PlayEffect();
      }
   }
}

